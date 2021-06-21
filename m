Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C328A3AE944
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 14:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUMnV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 08:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229651AbhFUMnV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 08:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624279266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UX4hH0orljGAjRfyNzYEtqzSPWXSws7HgqHEwdcv2h8=;
        b=E89KHkwIJbGs5xn0pNqa5YU3oWLavuqT2kRtupUOQTDdwSPRmp7sKH/f00Kee0uEixIVEi
        4jw+WFK0v/2wal0y3nWElQLxPsueizh+J0JmYG64Eda9wfI9jo2VJxE/9f1wQG0UjUGGVB
        3AggyuMa0zgzOQ5OcnNJp7ci+slmZQE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-PmhbMwRmPxOF3GUlr5q8YQ-1; Mon, 21 Jun 2021 08:41:05 -0400
X-MC-Unique: PmhbMwRmPxOF3GUlr5q8YQ-1
Received: by mail-ej1-f72.google.com with SMTP id w22-20020a17090652d6b029048a3391d9f6so110004ejn.12
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jun 2021 05:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UX4hH0orljGAjRfyNzYEtqzSPWXSws7HgqHEwdcv2h8=;
        b=oStuVLSTVJcGz83XXPrWAI44xVu4x/YHM8lsNVpk5LlWhBvT2FjXGuy9Ot/14PkNaj
         NdvQjY0q51NNmHB/NjHCQmSqWmSFtuRlDukFWbZOwvdMTUC6wbHX9+1VGaPlvpeX5I2b
         CxAoOFPvOeWaBv4SV08RUuCRmuCW3DZi25FDU9ATPjFnNd7H1zZYF4GfYnUZ3Y3ilJ2g
         BpO9PldCcxwGprke7pmgUwuYvsPfsf83zuKh86SS62WqY7SjJnC5NB793mmRmfXkzV86
         YlzryGpRl9uIz2SBvZpo3ujcYoMFfiYGIYfL3mJRGUyP7htRHAZDSgWJv/A0k5L6Qn2r
         6NgQ==
X-Gm-Message-State: AOAM533ixVgSfe4UIs+1sv0dwdvpPT/iP59ujN4gqkulq2+pFRsPRc/O
        bELRXa9hiauOHdwCMEis1yF10g25eyU5yD8oXrLAFs9kGABGX417FfXO2jiNAJOoXwngPzbK617
        /1gM1c0tA0eplYn2MpcbrGeD+MBM=
X-Received: by 2002:a17:906:b55:: with SMTP id v21mr1292857ejg.88.1624279264383;
        Mon, 21 Jun 2021 05:41:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynWFPGDBeQoVs0wQFxZ6ukyvwpQ+InHpUPcAZ0QWYBeYA1wQXU3lIm+AdsMolUbicJN1wqXA==
X-Received: by 2002:a17:906:b55:: with SMTP id v21mr1292837ejg.88.1624279264280;
        Mon, 21 Jun 2021 05:41:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ci12sm4817907ejc.17.2021.06.21.05.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:41:03 -0700 (PDT)
Subject: Re: [PATCH v2] brcmfmac: fix "board_type" in brcmf_of_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
References: <YNCHELb14+eNV94n@mwanda>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6e0b8291-8c61-c172-30ce-031910009d04@redhat.com>
Date:   Mon, 21 Jun 2021 14:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNCHELb14+eNV94n@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 6/21/21 2:33 PM, Dan Carpenter wrote:
> There are two bugs here:
> 1) devm_kzalloc() needs to be checked for allocation errors.
> 2) The loop was intended to be:
> 
>  Bad:	for (i = 0; i < board_type[i]; i++) {
> Good:	for (i = 0; i < len; i++) {
> 
> Neither of these bugs are likely to cause an issue in practice but
> they're worth fixing.  Also the code could be made simpler by using the
> devm_kstrdup() and strreplace() functions.
> 
> Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Basically a completely different patch.  :)
> 
>  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index a7554265f95f..8ca62cd0e8ac 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -24,20 +24,16 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>  	/* Set board-type to the first string of the machine compatible prop */
>  	root = of_find_node_by_path("/");
>  	if (root) {
> -		int i, len;
>  		char *board_type;
>  		const char *tmp;
>  
>  		of_property_read_string_index(root, "compatible", 0, &tmp);
>  
>  		/* get rid of '/' in the compatible string to be able to find the FW */
> -		len = strlen(tmp) + 1;
> -		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> -		strscpy(board_type, tmp, len);
> -		for (i = 0; i < board_type[i]; i++) {
> -			if (board_type[i] == '/')
> -				board_type[i] = '-';
> -		}
> +		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
> +		if (!board_type)
> +			return;

The error handling here seems to be lacking, specifically
this error-exit path needs a of_node_put(root); call (or
a "goto put;" or some such)

Regards,

Hans



> +		strreplace(board_type, '/', '-');
>  		settings->board_type = board_type;
>  
>  		of_node_put(root);
> 

