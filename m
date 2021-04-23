Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79FB3691AA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbhDWMA3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhDWMA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 08:00:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A47C061574;
        Fri, 23 Apr 2021 04:59:53 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lZuTB-00FeW1-OS; Fri, 23 Apr 2021 13:59:37 +0200
Message-ID: <427e33af49758c61bc23cf1eedb6dd6964c40296.camel@sipsolutions.net>
Subject: Re: [PATCH] brcmfmac: fix a loop exit condition
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
Date:   Fri, 23 Apr 2021 13:59:36 +0200
In-Reply-To: <YIKzmoMiTdToaIyP@mwanda> (sfid-20210423_134702_525310_A6DD2972)
References: <YIKzmoMiTdToaIyP@mwanda> (sfid-20210423_134702_525310_A6DD2972)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-04-23 at 14:46 +0300, Dan Carpenter wrote:
> This code is supposed to loop over the whole board_type[] string.  The
> current code kind of works just because ascii values start 97 and the
> string is likely shorter than that so it will break when we hit the NUL
> terminator.  But really the condition should be "i < len" instead of
> "i < board_type[i]".
> 
> Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index a7554265f95f..9b75e396fc50 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -34,7 +34,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  		len = strlen(tmp) + 1;
>  		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
>  		strscpy(board_type, tmp, len);
> -		for (i = 0; i < board_type[i]; i++) {
> +		for (i = 0; i < len; i++) {
>  			if (board_type[i] == '/')
>  				board_type[i] = '-';
>  		}

It should probably just use strreplace() though :)

johannes

