Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7BCD9831
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2019 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfJPRGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 13:06:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38775 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfJPRGd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 13:06:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so7737970pgt.5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1bwF6MwDSDXf1V/a7S6mx1WIoLAxLUM0dW2SsFZ9Kfs=;
        b=PperQNYG0yoXPZXRVzIa8FjlCsQk6E8H2A9Xo/ZkhFgNEn+UFzPGxcOOBuafMriaPR
         otSGZax0qcJFlf/KDOZKp49cz3kv8mSNcA1MGLbbyH1g8qar7s3/f4Zmbshf7+lCU05u
         5gB5TDYvasdOYlnJLDr6nA5xpUgU5JbEw2Bw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1bwF6MwDSDXf1V/a7S6mx1WIoLAxLUM0dW2SsFZ9Kfs=;
        b=UqutB0c1rZi/YVoJfmS7z8+zjJby9pm2HRkZbqgS9IuU1WUn+U4VyKHVdjwyjqp4mX
         Ke0HYdgR+Ft8N0G4gkID9Wfkvs/ss/scKkdukYrUX0Ud8p+l757AJg+J8dWFI7iO0aFY
         3MOSgyfcw0dKMv1JbM0pCMaLNjpwP/Ox//sME3XVLJ82KFCRuCtXGTYAX3zgZ1TfCB9C
         LaK/1OgoJgd9e7Ev/M3SLe60L/3yqnEVoUlQ2Fk3Eq+CKBu8t8IShINOJ7Av2psTbG76
         6DIBdUmgzgVcobrKrII88grUBLdulghzFp3hOqUpjVJx5PoG6HMqUSEMz9s1byaoh9S4
         OOeQ==
X-Gm-Message-State: APjAAAU9KYG6AyETx7z8QQjPZJOqHfY9VxZdjQC7EkPcKFNqPd1SGG2A
        8tpRd6Osl8UX9NxpBZzCX2UxkA==
X-Google-Smtp-Source: APXvYqwHoxnkCK3TBL7OEA8ITLs7TPlIgA/ZT7/VkFG27iyhJnOnB213LZKI9zJLt96QpdJhSdnx4w==
X-Received: by 2002:aa7:8ad0:: with SMTP id b16mr46834080pfd.255.1571245592605;
        Wed, 16 Oct 2019 10:06:32 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id s36sm26426626pgk.84.2019.10.16.10.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:06:31 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:06:29 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/6] rtw88: Enable 802.11ac beamformee support
Message-ID: <20191016170628.GA206123@google.com>
References: <20191016123301.2649-1-yhchuang@realtek.com>
 <20191016123301.2649-4-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016123301.2649-4-yhchuang@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Wed, Oct 16, 2019 at 08:32:58PM +0800, yhchuang@realtek.com wrote:
...
> diff --git a/drivers/net/wireless/realtek/rtw88/bf.h b/drivers/net/wireless/realtek/rtw88/bf.h
> new file mode 100644
> index 000000000000..96a8216dd11f
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/bf.h

...

> +void rtw_bf_disassoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
> +		     struct ieee80211_bss_conf *bss_conf);
> +void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
> +		  struct ieee80211_bss_conf *bss_conf);
> +void rtw_bf_init_bfer_entry_mu(struct rtw_dev *rtwdev,
> +			       struct mu_bfer_init_para *param);

Not used outside bf.c, so you should make it static in bf.c and drop the
declaration here.

> +void rtw_bf_cfg_sounding(struct rtw_dev *rtwdev, struct rtw_vif *vif,
> +			 enum rtw_trx_desc_rate rate);

Same.

> +void rtw_bf_cfg_mu_bfee(struct rtw_dev *rtwdev, struct cfg_mumimo_para *param);

Same.

> +void rtw_bf_del_bfer_entry_mu(struct rtw_dev *rtwdev);

Same.

> +void rtw_bf_del_sounding(struct rtw_dev *rtwdev);

Same.

> +void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
> +			   struct rtw_bfee *bfee);
> +void rtw_bf_enable_bfee_mu(struct rtw_dev *rtwdev, struct rtw_vif *vif,
> +			   struct rtw_bfee *bfee);
> +void rtw_bf_remove_bfee_su(struct rtw_dev *rtwdev, struct rtw_bfee *bfee);
> +void rtw_bf_remove_bfee_mu(struct rtw_dev *rtwdev, struct rtw_bfee *bfee);
> +void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
> +			  struct ieee80211_bss_conf *conf);
> +void rtw_bf_phy_init(struct rtw_dev *rtwdev);
> +void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
> +			 u8 fixrate_en, u8 *new_rate);
> +#endif
 
Brian
