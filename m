Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858ED3DFD3D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhHDIsd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 04:48:33 -0400
Received: from lpdvsmtp11.broadcom.com ([192.19.166.231]:51948 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235582AbhHDIsd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 04:48:33 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8E6F480D8;
        Wed,  4 Aug 2021 01:48:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8E6F480D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1628066900;
        bh=pt1KK0fcrEO6kMlem5B+QxkgrpxkL407PGTI8pa/FSg=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=ihx49GHxb4Ooinhl4Y65BbwJ/1QvcHNESc4HCJwue3PjKIC7YzVe1W5Q18pdoSPZd
         BWY284+/OunsAvGR2tGNwcZJMcVSpxTcPjBVsb/X2rXBIcq0+1SHnpZ90+E9j5jDRT
         cw/TFthwuo4BZ1k5LjzrsRqS8zUcvOZDZEMxmWj8=
Received: from [10.230.42.155] (unknown [10.230.42.155])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 5E7EA1874BD;
        Wed,  4 Aug 2021 01:48:16 -0700 (PDT)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
To:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        phone-devel@vger.kernel.org, newbyte@disroot.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20210711231659.255479-1-linus.walleij@linaro.org>
 <fca09928-72a8-a573-a862-7c486a2094d6@gmail.com>
 <02415358-6635-a974-7682-a721912ca4fc@gmail.com>
Message-ID: <a2ee7f03-879e-543f-fbaf-06a58e416e9d@broadcom.com>
Date:   Wed, 4 Aug 2021 10:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <02415358-6635-a974-7682-a721912ca4fc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 3, 2021 5:53:14 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> 03.08.2021 18:28, Dmitry Osipenko пишет:
>> 12.07.2021 02:16, Linus Walleij пишет:
>>> After some crashes in the 3D engine (!) on the Samsung GT-I8530
>>> it turns out that the main firmware file can be device dependent,
>>> something that was previously only handled for the NVRAM
>>> parameter file.
>>>
>>> Rewrite the code a bit so we can a per-board suffixed firmware
>>> binary as well, if this does not exist we fall back to the
>>> canonical firmware name.
>>>
>>> Example: a 4330 device with the OF board compatible is
>>> "samsung,gavini". We will first try
>>> "brcmfmac4330-sdio.samsung,gavini.bin" then "brcmfmac4330-sdio.bin"
>>> if that does not work.
>>>
>>> Cc: phone-devel@vger.kernel.org
>>> Cc: newbyte@disroot.org
>>> Cc: Stephan Gerhold <stephan@gerhold.net>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> .../broadcom/brcm80211/brcmfmac/firmware.c    | 53 +++++++++++++++----
>>> 1 file changed, 42 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c 
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>>> index d40104b8df55..adfdfc654b10 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>>> @@ -594,28 +594,47 @@ static int brcmf_fw_complete_request(const struct 
>>> firmware *fw,
>>> return (cur->flags & BRCMF_FW_REQF_OPTIONAL) ? 0 : ret;
>>> }
>>>
>>> +static char *brcm_alt_fw_path(const char *path, const char *board_type)
>>> +{
>>> + char alt_path[BRCMF_FW_NAME_LEN];
>>> + char suffix[5];
>>> +
>>> + strscpy(alt_path, path, BRCMF_FW_NAME_LEN);
>>> + /* At least one character + suffix */
>>> + if (strlen(alt_path) < 5)
>>> + return NULL;
>>> +
>>> + /* strip .txt or .bin at the end */
>>> + strscpy(suffix, alt_path + strlen(alt_path) - 4, 5);
>>> + alt_path[strlen(alt_path) - 4] = 0;
>>> + strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
>>> + strlcat(alt_path, board_type, BRCMF_FW_NAME_LEN);
>>> + strlcat(alt_path, suffix, BRCMF_FW_NAME_LEN);
>>> +
>>> + return kstrdup(alt_path, GFP_KERNEL);
>>> +}
>>> +
>>> static int brcmf_fw_request_firmware(const struct firmware **fw,
>>>   struct brcmf_fw *fwctx)
>>> {
>>> struct brcmf_fw_item *cur = &fwctx->req->items[fwctx->curpos];
>>> int ret;
>>>
>>> - /* nvram files are board-specific, first try a board-specific path */
>>> + /* Files can be board-specific, first try a board-specific path */
>>> if (cur->type == BRCMF_FW_TYPE_NVRAM && fwctx->req->board_type) {
>>> - char alt_path[BRCMF_FW_NAME_LEN];
>>> + char *alt_path;
>>>
>>> - strlcpy(alt_path, cur->path, BRCMF_FW_NAME_LEN);
>>> - /* strip .txt at the end */
>>> - alt_path[strlen(alt_path) - 4] = 0;
>>> - strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
>>> - strlcat(alt_path, fwctx->req->board_type, BRCMF_FW_NAME_LEN);
>>> - strlcat(alt_path, ".txt", BRCMF_FW_NAME_LEN);
>>> + alt_path = brcm_alt_fw_path(cur->path, fwctx->req->board_type);
>>> + if (!alt_path)
>>> + goto fallback;
>>>
>>> ret = request_firmware(fw, alt_path, fwctx->dev);
>>> + kfree(alt_path);
>>> if (ret == 0)
>>> return ret;
>>> }
>>>
>>> +fallback:
>>> return request_firmware(fw, cur->path, fwctx->dev);
>>> }
>>>
>>> @@ -660,6 +679,7 @@ int brcmf_fw_get_firmwares(struct device *dev, struct 
>>> brcmf_fw_request *req,
>>> {
>>> struct brcmf_fw_item *first = &req->items[0];
>>> struct brcmf_fw *fwctx;
>>> + char *alt_path;
>>> int ret;
>>>
>>> brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
>>> @@ -677,9 +697,20 @@ int brcmf_fw_get_firmwares(struct device *dev, struct 
>>> brcmf_fw_request *req,
>>> fwctx->req = req;
>>> fwctx->done = fw_cb;
>>>
>>> - ret = request_firmware_nowait(THIS_MODULE, true, first->path,
>>> -      fwctx->dev, GFP_KERNEL, fwctx,
>>> -      brcmf_fw_request_done);
>>> + /* First try alternative board-specific path if any */
>>> + alt_path = brcm_alt_fw_path(first->path, fwctx->req->board_type);
>>> + if (alt_path) {
>>> + ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
>>> +      fwctx->dev, GFP_KERNEL, fwctx,
>>> +      brcmf_fw_request_done);
>
> This return 0 immediately, despite of the missing firmware file. It's
> not a blocking FW request.

Right. I didn't get to looking at this earlier, but indeed the check 
whether the requested firmware exists is done in another thread context 
so the return value here only indicates whether the firmware request 
could be scheduled or not.

My first reaction to the patch was to reject it, but leaning towards 
supporting this now. OEMs tend to get tailor-made firmware in terms of 
features. Depending on their requirements they get their mix of firmware 
features. That such difference lead to a crash in 3d engine is somewhat 
surprising. I am curious if we can debug this more and learn how a 
firmware variant could cause such a crash. Maybe some DMA issue?

Regards,
Arend

