Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B932D3DF1D5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Aug 2021 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhHCPxY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Aug 2021 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbhHCPxY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Aug 2021 11:53:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09030C061757;
        Tue,  3 Aug 2021 08:53:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m13so40502421lfg.13;
        Tue, 03 Aug 2021 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kaWRE1O6AcnaVx8r93TzfdyCAI7qw1zjJpE/bSW5ltg=;
        b=pL2zLf5hjx5IS6IoF8VHilZqDXNvQpFRyVNM3ppycYHJyWcNI7zssdTXmBTu08tEod
         XmEAvBITNP3Dh+nX8NxOJr/qI3aKKPVVSqEH+65nMbiXPEOu4HYr3eG63Sit6UvbFvhU
         8A/xNXxt3fPUNEbBkFAMaU7Qa3HtLsgKbVP6lHs+UUaBcoUUaqlgHG+6uS9/YM2DutPI
         0v2JKYTpJtKTdNPIQ8lDFS+TyHClZb68FutTEVWQdLxM6ccIpzfSuxefh5yXjmZiPHPD
         aj3YcG2HXT1K6yC99GavpEy2HKmkSw4TjIBq+hfF7hEph+EyfAhQSQq3YNK9z9i0JVdD
         12WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kaWRE1O6AcnaVx8r93TzfdyCAI7qw1zjJpE/bSW5ltg=;
        b=VsCDdH6FvrUgG/hCrHmTWkqKsHRHZqnWMHm5L0fBRphIanWnkopRgfIt7rD3jcrMUr
         9VwIfFGEYSeiipz4uqQXICchQL71ndKACuwA+RWSNhx2aVlRHL5fRYlmWqOpcylMIwEU
         nIVnd0RCPrVI4NmAMoXzjcgxF3mQJPh788jSlT8zLmqbAhaXv0wB6e8HVI25zl9jJWBF
         RHEX/zbbdRjZT7URvuLu/81PbcUFgUWjcDpU00iC7eT674D58ZzaPK2+ADthGpCyHmGL
         hyvDpOCurtlLPRNcy/RAhq9JDCO+btT/sdp9qn+ZhnZN5Rorimx44xON8xJMHNzBZikV
         dSXQ==
X-Gm-Message-State: AOAM533oUgoQeu2UDqTVfqZFYX7cRwpMKOHQkcAM2iGev3+V2wDoZr3d
        oSAbbZuc4hExnnIFjpy3tAY=
X-Google-Smtp-Source: ABdhPJxlfe3NZpqFej1u4hqrvFr1U3geNkEZ07aFV9d/Thd1WR8ylz5FVGY0gEWRJ56WpoQBel+dtg==
X-Received: by 2002:a19:e002:: with SMTP id x2mr16797313lfg.84.1628005990411;
        Tue, 03 Aug 2021 08:53:10 -0700 (PDT)
Received: from [192.168.2.145] (46-138-51-120.dynamic.spd-mgts.ru. [46.138.51.120])
        by smtp.googlemail.com with ESMTPSA id s12sm1409847lfr.60.2021.08.03.08.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 08:53:10 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <02415358-6635-a974-7682-a721912ca4fc@gmail.com>
Date:   Tue, 3 Aug 2021 18:53:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fca09928-72a8-a573-a862-7c486a2094d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

03.08.2021 18:28, Dmitry Osipenko пишет:
> 12.07.2021 02:16, Linus Walleij пишет:
>> After some crashes in the 3D engine (!) on the Samsung GT-I8530
>> it turns out that the main firmware file can be device dependent,
>> something that was previously only handled for the NVRAM
>> parameter file.
>>
>> Rewrite the code a bit so we can a per-board suffixed firmware
>> binary as well, if this does not exist we fall back to the
>> canonical firmware name.
>>
>> Example: a 4330 device with the OF board compatible is
>> "samsung,gavini". We will first try
>> "brcmfmac4330-sdio.samsung,gavini.bin" then "brcmfmac4330-sdio.bin"
>> if that does not work.
>>
>> Cc: phone-devel@vger.kernel.org
>> Cc: newbyte@disroot.org
>> Cc: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  .../broadcom/brcm80211/brcmfmac/firmware.c    | 53 +++++++++++++++----
>>  1 file changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> index d40104b8df55..adfdfc654b10 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> @@ -594,28 +594,47 @@ static int brcmf_fw_complete_request(const struct firmware *fw,
>>  	return (cur->flags & BRCMF_FW_REQF_OPTIONAL) ? 0 : ret;
>>  }
>>  
>> +static char *brcm_alt_fw_path(const char *path, const char *board_type)
>> +{
>> +	char alt_path[BRCMF_FW_NAME_LEN];
>> +	char suffix[5];
>> +
>> +	strscpy(alt_path, path, BRCMF_FW_NAME_LEN);
>> +	/* At least one character + suffix */
>> +	if (strlen(alt_path) < 5)
>> +		return NULL;
>> +
>> +	/* strip .txt or .bin at the end */
>> +	strscpy(suffix, alt_path + strlen(alt_path) - 4, 5);
>> +	alt_path[strlen(alt_path) - 4] = 0;
>> +	strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
>> +	strlcat(alt_path, board_type, BRCMF_FW_NAME_LEN);
>> +	strlcat(alt_path, suffix, BRCMF_FW_NAME_LEN);
>> +
>> +	return kstrdup(alt_path, GFP_KERNEL);
>> +}
>> +
>>  static int brcmf_fw_request_firmware(const struct firmware **fw,
>>  				     struct brcmf_fw *fwctx)
>>  {
>>  	struct brcmf_fw_item *cur = &fwctx->req->items[fwctx->curpos];
>>  	int ret;
>>  
>> -	/* nvram files are board-specific, first try a board-specific path */
>> +	/* Files can be board-specific, first try a board-specific path */
>>  	if (cur->type == BRCMF_FW_TYPE_NVRAM && fwctx->req->board_type) {
>> -		char alt_path[BRCMF_FW_NAME_LEN];
>> +		char *alt_path;
>>  
>> -		strlcpy(alt_path, cur->path, BRCMF_FW_NAME_LEN);
>> -		/* strip .txt at the end */
>> -		alt_path[strlen(alt_path) - 4] = 0;
>> -		strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
>> -		strlcat(alt_path, fwctx->req->board_type, BRCMF_FW_NAME_LEN);
>> -		strlcat(alt_path, ".txt", BRCMF_FW_NAME_LEN);
>> +		alt_path = brcm_alt_fw_path(cur->path, fwctx->req->board_type);
>> +		if (!alt_path)
>> +			goto fallback;
>>  
>>  		ret = request_firmware(fw, alt_path, fwctx->dev);
>> +		kfree(alt_path);
>>  		if (ret == 0)
>>  			return ret;
>>  	}
>>  
>> +fallback:
>>  	return request_firmware(fw, cur->path, fwctx->dev);
>>  }
>>  
>> @@ -660,6 +679,7 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
>>  {
>>  	struct brcmf_fw_item *first = &req->items[0];
>>  	struct brcmf_fw *fwctx;
>> +	char *alt_path;
>>  	int ret;
>>  
>>  	brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
>> @@ -677,9 +697,20 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
>>  	fwctx->req = req;
>>  	fwctx->done = fw_cb;
>>  
>> -	ret = request_firmware_nowait(THIS_MODULE, true, first->path,
>> -				      fwctx->dev, GFP_KERNEL, fwctx,
>> -				      brcmf_fw_request_done);
>> +	/* First try alternative board-specific path if any */
>> +	alt_path = brcm_alt_fw_path(first->path, fwctx->req->board_type);
>> +	if (alt_path) {
>> +		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
>> +					      fwctx->dev, GFP_KERNEL, fwctx,
>> +					      brcmf_fw_request_done);

This return 0 immediately, despite of the missing firmware file. It's
not a blocking FW request.
