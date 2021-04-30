Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B636F366
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Apr 2021 03:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhD3BLV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 21:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3BLV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 21:11:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE6C06138B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 18:10:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so838300pjh.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/jsPVVLG1V7iAfhSen5vIhfZuI4dhkQMq6auxsiAbIE=;
        b=dsBR2Lvgj680aEq7i53F840m/YfI64ql37n4rZ/7F9nWI14OgGAB0TkDKVEWhKTeb8
         5JiYXgxWIYXQum49Abvw2cYPfIBAqC358VKd9KMKH7DhDqq4pauSMdsKGKzc1uBbZyyz
         FdSYPCsHUYs4YS97YjRCZkw1oeHGIaHoeRRfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jsPVVLG1V7iAfhSen5vIhfZuI4dhkQMq6auxsiAbIE=;
        b=BfBSVByAa6+JHim1HMKd7/GVy0yF+14RgJ4xZ5T0GzlsbtGPVCF4Dq29PHiMjv0s2c
         a/9LItHB5uNFQrvaZLDe7iDlGy8L+HU+md6BwbKDQWvsrSwrhN1cbfIp3M8MGtyeOdrQ
         5osKv+Kv//CoPBRXR/a+GBJOxciCHR5O55S8O6A9cqsztV9ceQiHT2f8wCcIzEZen/2d
         EK2xFv1fRUDR61RrXlUL2iMauRQLK5So9sJnr38to+eyK4ki0Bpy0D2BrIz8EoU8Bk5k
         FYsVOmCVAMyoEJU9dxzkduPUmNCuZjruWuf1XxaIXthibLoM7FpCoSjhVSaR0urWL6Aw
         7Kdw==
X-Gm-Message-State: AOAM533Y8xOEAfnHX9TGm9NvvCA8PYO66DaOqqH9+5thWG+nUijlKdTP
        ZRKuIeRrUagZ8tOyOGNqnZbILA==
X-Google-Smtp-Source: ABdhPJwEHj2vNV8qH9pMdK35bzgN4+/eQAuKSAuqrDL7XS/w3J6W+/oScFLeqxZVE80kCmrUGVApHQ==
X-Received: by 2002:a17:90b:3504:: with SMTP id ls4mr11941245pjb.222.1619745033419;
        Thu, 29 Apr 2021 18:10:33 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4f7:2f75:b0c0:5f85])
        by smtp.gmail.com with ESMTPSA id k69sm1236952pgc.45.2021.04.29.18.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 18:10:32 -0700 (PDT)
Date:   Thu, 29 Apr 2021 18:10:30 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 06/19] rtw89: add files to download and communicate
 with firmware
Message-ID: <YItZBolH5sSYZT3v@google.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
 <20210429080149.7068-7-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429080149.7068-7-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Small review note, since I was looking through the PS code due to
another bug in this patchset:

On Thu, Apr 29, 2021 at 04:01:36PM +0800, Ping-Ke Shih wrote:
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> +
> +#define H2C_LPS_PARM_LEN 8
> +int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev, u8 macid)

You're not actually using the macid param from this function. Instead,
you're implicitly passing data to this function via
rtwdev->lps_parm...except that it looks like you only set and use it
directly in this callchain, and you don't actually need to save it in
your driver structure.

IIUC, I believe this would be clearer and less error-prone if you just
pass a 'struct rtw89_lps_parm' arg (here, and in
rtw89_fw_h2c_general_pkt()), and drop 'struct rtw89_lps_parm' from
rtwdev.

Brian

> +{
> +	struct sk_buff *skb;
> +	struct rtw89_lps_parm *lps_param = &rtwdev->lps_parm;
> +
> +	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_LPS_PARM_LEN);
> +	if (!skb) {
> +		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
> +		return -ENOMEM;
> +	}
> +	skb_put(skb, H2C_LPS_PARM_LEN);
> +
> +	SET_LPS_PARM_MACID(skb->data, lps_param->macid);
> +	SET_LPS_PARM_PSMODE(skb->data, lps_param->psmode);
> +	SET_LPS_PARM_LASTRPWM(skb->data, lps_param->lastrpwm);
> +	SET_LPS_PARM_RLBM(skb->data, 1);
> +	SET_LPS_PARM_SMARTPS(skb->data, 1);
> +	SET_LPS_PARM_AWAKEINTERVAL(skb->data, 1);
> +	SET_LPS_PARM_VOUAPSD(skb->data, 0);
> +	SET_LPS_PARM_VIUAPSD(skb->data, 0);
> +	SET_LPS_PARM_BEUAPSD(skb->data, 0);
> +	SET_LPS_PARM_BKUAPSD(skb->data, 0);
> +
> +	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
> +			      H2C_CAT_MAC,
> +			      H2C_CL_MAC_PS,
> +			      H2C_FUNC_MAC_LPS_PARM, 0, 1,
> +			      H2C_LPS_PARM_LEN);
> +
> +	if (rtw89_h2c_tx(rtwdev, skb, false)) {
> +		rtw89_err(rtwdev, "failed to send h2c\n");
> +		goto fail;
> +	}
> +
> +	return 0;
> +fail:
> +	dev_kfree_skb_any(skb);
> +
> +	return -EBUSY;
> +}

