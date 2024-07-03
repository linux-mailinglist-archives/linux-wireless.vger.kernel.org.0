Return-Path: <linux-wireless+bounces-9937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4C9267F3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 20:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756D91F211D4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586218411C;
	Wed,  3 Jul 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kANRCXyE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9E185093
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030583; cv=none; b=MXITTh2XjarS3RiLSbkOcU+Ba7LhQVqfFxZXkqiPY4tXLcNfP13aBnJjRqB1CnvgL+PpjLhXBo6+5UUZSFRkJKzxx38+R0Pj0Eb8uXKK1tetj2oLZH26zlxrujxWbTlYOC6r5P/hkZlspvZnvb61PzrUaJ+rqVthTtp/T3IsF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030583; c=relaxed/simple;
	bh=INhR2fa0yGgxgtZltkVdypg5VG4+m2mcYKfjkCtHMC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFf59tzdgsSFANeZZ6tjF4nA68CVnEc9jeyqrBuaotRhIouwSEqqvkSy/gtcf8DEu2Mej3QK5c0MbvQ6YY45CqwM9NFr6vdzSpjJSwH0ENHK2psDnksQ34F1wxfYf4haIv3BqcOcCtjwtNaHcvQWfcJWDWuFsnNeVUAWCbbUpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kANRCXyE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e96d4986bso1239631e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720030580; x=1720635380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e40U7mcSWYdfEv2YmbTar69IueSBy3KQw/j2MAMkE0Q=;
        b=kANRCXyEpOf3RlTmkqcpEsCKyXl2sQQVUPqi2jYvqHAJRoT3YZRYTDwkQs2W0/0TG0
         1KLrxXge0D7daBjwVvfonrCCogCDP4bJvXztl2IVdKMtnL0+MDKZ0vMcEaDJpuHSMUBu
         Yxdn3oa+aLkBhe4IqKag5SYNWvQrA9sWcHUGPyjqcXkLFOGF2f62hGbexhX+FsxP1tHG
         m6yLUYXB2PWuPnW7rgPcEb+dsqanGUdK5aROyRJEtp2ztXxbyegBRIMYCsRjtWXeIYDG
         1Hsd9nH+2HFHKw7sj7OHB+jjWdWrtyF87z7r1gmgSA45Is8YCuco8g4SRxIymsHSgZfo
         TSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030580; x=1720635380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e40U7mcSWYdfEv2YmbTar69IueSBy3KQw/j2MAMkE0Q=;
        b=PBojwIApmQ3TV850zas6iEl9G+nr6mopUHENYMJm483R4j0tsxkxoP+RhvFe87+Qks
         S7vbjb5u+2LMacARArJ0OY0m0gtRkJ2+cuzD1jCoR27WBANdDdNW+5++l3zYVAtTowTr
         vCPU75huy34eLaS55F9zsYWaya5Zr5mKZ6/ynXtecZTM3D2Y+prEv/yRODOYFeLalHD5
         /e8AKHzLbj+RrezkmiTepfAXhPj8u1IOSbPZjvC1OY0YPF9bP6E1kPIcreFRUK6km28F
         VpM2uB24Awrw37LFcdauoiraPG3Hk3sMvC1la2Lyz3171wV95Aa4rt5OBE/Pp/YNSJ5Z
         f67g==
X-Forwarded-Encrypted: i=1; AJvYcCXws7BAKl3jYEShtzAkUuXxWBddMxvNLptnPXxsAHjK5jTCKut0tL0em1Py2QcziACKLzWkM2iPVZCDhepOiiAUXy+8yFOWJuHI2SebBOE=
X-Gm-Message-State: AOJu0YzhTMbtI1LmkJbgTozTroieEHBNSI0OG+ZR7pyHxI50zZF32AI3
	eTb0Jk/GxVmpyEb4MlqTlUarVTLlAa5UxmKYDlt9G6qAG4/HKLJTivIbWg==
X-Google-Smtp-Source: AGHT+IFLjV2rEdsgLCpqlW5qwKxf0z2pQDN8I/EMC2I0d3l4UcX2lrt6expAxythTzgQAJQWOUIofQ==
X-Received: by 2002:a05:6512:3b81:b0:52c:dc25:d706 with SMTP id 2adb3069b0e04-52e8270172cmr8409306e87.52.1720030579751;
        Wed, 03 Jul 2024 11:16:19 -0700 (PDT)
Received: from shift.daheim (p200300d5ff30930050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff30:9300:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58cd108c84bsm1211462a12.47.2024.07.03.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:16:19 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1sP5Pz-000000001xA-1nyD;
	Wed, 03 Jul 2024 20:16:18 +0200
Message-ID: <19cb41af-6197-4977-b8e8-9c9bcdb3dc61@gmail.com>
Date: Wed, 3 Jul 2024 20:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] wiphy_register fails for mvm (AX211)
To: Alexander Wetzel <Alexander@wetzel-home.de>,
 miriam.rachel.korenblit@intel.com
Cc: ilan.peer@intel.com, johannes.berg@intel.com, johannes@sipsolutions.net,
 linux-wireless@vger.kernel.org
References: <20240618200104.3213638262ef.I2a0031b37623d7763fd0c5405477ea7206a3e923@changeid>
 <20240702104128.26394-1-Alexander@wetzel-home.de>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20240702104128.26394-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 12:41 PM, Alexander Wetzel wrote:
> The commit 5c38bedac16a ("wifi: iwlwifi: mvm: unify and fix interface
> combinations") breaks mvm hard. wlan interface can't be created and even
> rmmod fails.
> 
> On driver load I get:
> 
> WARNING: CPU: 5 PID: 1358 at net/wireless/core.c:689 wiphy_register+0x8ee/0x920 [cfg80211]
ran into the same issue. Debugging revealed that the " - 1" is the problem
because wiphy_verify_combinations checks if the specified limits in n_limits.max
adds up to at least max_interfaces (=3), which isn't true anymore with the
" - 1" as the ieee80211_iface_limit with NL80211_IFTYPE_P2P_DEVICE is missing.

Not sure, if this needs fixing in cfg80211 or iwlwifi. But I can confirm that this
patch "works" (not sure if it's correct/intended though).
---
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 60bfe42d5386..e40f993b17fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -59,13 +59,13 @@ static const struct ieee80211_iface_combination iwl_mvm_iface_combinations[] = {
  		.num_different_channels = 2,
  		.max_interfaces = 3,
  		.limits = iwl_mvm_limits,
-		.n_limits = ARRAY_SIZE(iwl_mvm_limits) - 1,
+		.n_limits = ARRAY_SIZE(iwl_mvm_limits),
  	},
  	{
  		.num_different_channels = 1,
  		.max_interfaces = 3,
  		.limits = iwl_mvm_limits_ap,
-		.n_limits = ARRAY_SIZE(iwl_mvm_limits_ap) - 1,
+		.n_limits = ARRAY_SIZE(iwl_mvm_limits_ap),
  	},
  };
---

relevant iw phy dump

         valid interface combinations:
                  * #{ managed } <= 1, #{ P2P-client, P2P-GO } <= 1, #{ P2P-device } <= 1,
                    total <= 3, #channels <= 2
                  * #{ managed } <= 1, #{ AP, P2P-client, P2P-GO } <= 1, #{ P2P-device } <= 1,
                    total <= 3, #channels <= 1


Cheers,
Christian


