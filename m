Return-Path: <linux-wireless+bounces-12956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F197BC2B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AD6284427
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E117C9BA;
	Wed, 18 Sep 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U+MFAJVu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6C17837E
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662190; cv=none; b=B7mT+cdAySfdwG97MLsHxd70LOXhbYGU3Gmlv5qAAWn7ad3NuXMY9fyQirsNVSQLNghDKkLLyWKlPIy9NHQWIkmXLSKHD9YXQdXbrcCwEiqgMTWtrR+WoZVVNMYziTSDPh9qPeqT28og4h9R2E9y5KVZUrXqY2ke6T1znWE/+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662190; c=relaxed/simple;
	bh=ROwB+K5OKaha/YoKAJT+JWYCMNMWOIxJJIiw0cPA+dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJyk4ujvRdDdGGToQ6lD7gfr5OkL8Gy3zhzX+w7YdMHxE6bsGWiO+k9tWOMBX4/NKHmNOlVW9JXwpDy1Zi6zie4g4AKM3Fc8aXiMtFpZLEtLN//QPeCH8MZ7OPmWtwosHMiR4ibaMFv4VErjWHzQGdXRVoi/nXHPPWCnkCFAhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U+MFAJVu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75f116d11so60018221fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726662186; x=1727266986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vd3YCQ/eSNeV3c/sXDZ+VbkEXkHCqUvvX/6+kFUqNOY=;
        b=U+MFAJVu7KG8ZgLy0hGfApV4PkIHsQO2yIUB5SaAd4/NSLHe9h7fvIyH5jtIK5KsUP
         T3m3Jy7cIpYyJG9IfWSEOEdNrkMpKtg+wiHJvdHCw38LgwmAABJJCYFhYVN15GUiHYSv
         BUKWwECboBurXAjJ253LMC5Gbo8Yu/a1kKmUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662186; x=1727266986;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd3YCQ/eSNeV3c/sXDZ+VbkEXkHCqUvvX/6+kFUqNOY=;
        b=O5HvKsRjyIBKdS9UHjIqO/+Qi7lhAtYgVacnAaFPOBe4259ZDA3Vvv1cYEbAafuZiw
         G/wAu4QgaEWV8Jx6tG1UpCClVtQKNDTWfREGx5lArJKL01at7XkaRsPPoQihPTtWdmXY
         KyJSDWAWbFzg29OSLTK0C4eoPYvoNwt6tM9UqREGvzDeJrVliH0uAP5sjeGQ+K/S3Nb2
         WB2wc3I60i2tSOk0F657YRPnkYcxXCQcXTK+4zUQp87I+WjKZFRWJwRQ8/zqdoK0h2Vq
         u6X57VJ1V0YXjUsnZMkCV3gCU9aw0JFgw8p2pVtMslidIgOt4PHgOxUWEX2bntEc4Rft
         vIMw==
X-Forwarded-Encrypted: i=1; AJvYcCUlhb97iDEay45kLD7Za7jrdGLc/g+oKA01SdFt6AgINiLnFTZe8KKhgPMMYUQK+L0NOYHcZeSRBKLJEFxKTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTL7PTBARUHXI7LEprlIwmn+ZBYP+P+eHtXoh0wG6vjSBQ589
	48UNTzc5Wug0iziHmg/vSknQy296jWPjK1yVR6t9hVMwWaWAzf32U8+RIRqNCA==
X-Google-Smtp-Source: AGHT+IEPc4FTxCzs0HLLpQenloYN/eVTYZwTdwufe8LSOf1mbBnucke4Jus2uzSznki6Kv2wQbqK+g==
X-Received: by 2002:a05:651c:4cb:b0:2f7:4f46:8344 with SMTP id 38308e7fff4ca-2f7a2a48ec5mr60736591fa.21.1726662186004;
        Wed, 18 Sep 2024 05:23:06 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e704d8329sm16015295e9.6.2024.09.18.05.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 05:23:05 -0700 (PDT)
Message-ID: <37b61ce2-1db5-419d-b9f6-2b68cf12c1bb@broadcom.com>
Date: Wed, 18 Sep 2024 14:23:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT 3/3] wifi: brcmfmac: cyw: support external SAE
 authentication in station mode
To: Kalle Valo <kvalo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>
References: <20240915140049.181380-4-arend.vanspriel@broadcom.com>
 <202409181714.QfWaGA1c-lkp@intel.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <202409181714.QfWaGA1c-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/2024 9:31 AM, kernel test robot wrote:
> Hi Arend,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 34c44eb31de9cb7202ff070900463d6c706392c4]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Arend-van-Spriel/wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events/20240915-220310
> base:   34c44eb31de9cb7202ff070900463d6c706392c4
> patch link:    https://lore.kernel.org/r/20240915140049.181380-4-arend.vanspriel%40broadcom.com
> patch subject: [RFT 3/3] wifi: brcmfmac: cyw: support external SAE authentication in station mode
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240918/202409181714.QfWaGA1c-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409181714.QfWaGA1c-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409181714.QfWaGA1c-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c: In function 'brcmf_cyw_mgmt_tx':
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:118:13: warning: variable 'timeout' set but not used [-Wunused-but-set-variable]
>       118 |         s32 timeout;
>           |             ^~~~~~~
>     drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c: At top level:
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:52:42: warning: 'brcmf_cyw_event_map' defined but not used [-Wunused-const-variable=]
>        52 | static const struct brcmf_fweh_event_map brcmf_cyw_event_map = {
>           |                                          ^~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/timeout +118 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> 
>      51	
>    > 52	static const struct brcmf_fweh_event_map brcmf_cyw_event_map = {
>      53		.items = {
>      54			{ BRCMF_E_EXT_AUTH_REQ, BRCMF_CYW_E_EXT_AUTH_REQ },
>      55			{ BRCMF_E_EXT_AUTH_FRAME_RX, BRCMF_CYW_E_EXT_AUTH_FRAME_RX },
>      56			{ BRCMF_E_MGMT_FRAME_TXSTATUS, BRCMF_CYW_E_MGMT_FRAME_TXS },
>      57			{
>      58				BRCMF_E_MGMT_FRAME_OFFCHAN_DONE,
>      59				BRCMF_CYW_E_MGMT_FRAME_TXS_OC
>      60			},
>      61		},
>      62		.n_items = 1

Something definitely went wrong here or in my head :-(

>      63	};
>      64	

[...]

>     101	static
>     102	int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>     103			      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
>     104	{
>     105		struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
>     106		struct ieee80211_channel *chan = params->chan;
>     107		struct brcmf_pub *drvr = cfg->pub;
>     108		const u8 *buf = params->buf;
>     109		size_t len = params->len;
>     110		const struct ieee80211_mgmt *mgmt;
>     111		struct brcmf_cfg80211_vif *vif;
>     112		s32 err = 0;
>     113		bool ack = false;
>     114		s32 chan_nr;
>     115		u32 freq;
>     116		struct brcmf_mf_params_le *mf_params;
>     117		u32 mf_params_len;
>   > 118		s32 timeout;
>     119	
>     120		brcmf_dbg(TRACE, "Enter\n");

[...]

>     175		timeout =
>     176			wait_for_completion_timeout(&vif->mgmt_tx,
>     177						    MGMT_AUTH_FRAME_WAIT_TIME);

Yep. Will fix it.

