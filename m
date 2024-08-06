Return-Path: <linux-wireless+bounces-11016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3494956C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5CA1F215E0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793072C697;
	Tue,  6 Aug 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX32w/a6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48918D635
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961218; cv=none; b=ToZMG0u47LQwDB20rpnUCiZKb6DK89AiJ3iR8nzEUMbaj+p09tHBhqppejn9+UFZMi45+RQB95LXynclQlZ67OZ+elzzuDX89n5XBdU28smw5b7kzyIUUiuKkaVoKn+S6qs1AKLR81qS+Sauc+09l7mQK03MP8yi+fGQVr/ogRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961218; c=relaxed/simple;
	bh=QGF0k1TWGzE5jzgFSuFqA69+VB3snYnp5wXjwUr0sOo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=b1mhFN/xHgCSvl4Rp55YEuFDwFaJ3IrrXeQ8Q6yHcTZbeCSxiKTjHTZnWwjtrAcH+UYg4EcLMkea6XpPP9lxNZPMFwPkoPY5bymm8hJ2pYONTE+vCWfiebsAbOYjBzugGtkrPIWuB4ipcOtrCPdWIDqUAuy1MZzi7p6XS9AWODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX32w/a6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so1067a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722961215; x=1723566015; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiN/Ze1hmgU2V1p7KS3+VNNxl5hiUjHqOyplxxEBFaI=;
        b=CX32w/a6YvUhNma5+Dr58xnEXK00R+SQyL5cpajr6ZJkn1/lebsiaBM8njr7z+7jSf
         JroVTrhurT+USyWCrcuV38TMa9HN/0zdV+VhsWjHeDxkKDtkLOHgyKyizX+xrTBaKUqY
         Nfaz91YePWm/xyjfL41BUuUJCUfUWK5gDD14mQvQ9Q2sXsi/f0s2oE7koKsjUwrXPasU
         8A8rXF/TTTcr+BPaAD/u0H9FRiC0KzcLYxlGz4gnZnfkoBygIZUCFlLq1OpgBFQQPfFq
         4vJjzLGo7uk75kcbiK/v1Wi89zOxccDse8hw+KsT2IbkxwInosu9i5PZbeIADB6fk6qQ
         Tx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961215; x=1723566015;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KiN/Ze1hmgU2V1p7KS3+VNNxl5hiUjHqOyplxxEBFaI=;
        b=Wd3fIZSc61z/Mcp03mxzPjHyMAMlMP/0ms7Rm0mJaHAVVpTjAhDVMYR0dQNkTYCaS2
         9ExxUmXL3CuoyX2at4ya0RHaaoaJ8J+/UZDZr8zY+wdpJZ6bSH1kM/mbDdUVl/ZGhFJd
         178Kx4j/p9p+sCMehooyRL+kqsNiZ3TVqEhlwFNs+COfNxXlLvLBGGa/V4viHrPTBnbv
         Hz6ZYuSu5qWVD86Hjzk8eGFfU/f+di9/YU6v06Xg3eC5CsCyjnRSZHLVCLqpFBvc2FlS
         IxEil2OpRZNWkzLa7e0je62qlzD3bCaaalDklz9+lhoAjbhFatUpgym50oFbCYBDhxLL
         5vAg==
X-Gm-Message-State: AOJu0YxRBP/HZaxubEFe0O2c7vjX7Ly5mrDdm4Oil4IrMI1q+4Zb3ndg
	DhhXmPVHfAs3X18xa5hk5Up7kIXD+9j4bo8M+egvU2Y1JzBwO54bDz4jtA==
X-Google-Smtp-Source: AGHT+IGdrCLFnf7a73zGsWvxGDVdLqhTp+2va6OMy0bJT+QUGhfAo98Rvn1pNMfbGDqmQ3Yj9c3YGw==
X-Received: by 2002:a50:eaca:0:b0:58c:36e:51bf with SMTP id 4fb4d7f45d1cf-5b80a6e0a79mr14228669a12.3.1722961214790;
        Tue, 06 Aug 2024 09:20:14 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a446b37sm6011208a12.57.2024.08.06.09.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:20:14 -0700 (PDT)
Message-ID: <2a808244-93d0-492c-b304-ae1974df5df9@gmail.com>
Date: Tue, 6 Aug 2024 19:20:11 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192du: Initialise value32 in
 _rtl92du_init_queue_reserved_page
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

GCC complains:

   In file included from include/linux/ieee80211.h:21,
                    from include/net/mac80211.h:20,
                    from drivers/net/wireless/realtek/rtlwifi/rtl8192du/../wifi.h:14,
                    from drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:4:
   In function 'u32p_replace_bits',
       inlined from '_rtl92du_init_queue_reserved_page.isra' at drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:225:2:
>> include/linux/bitfield.h:189:18: warning: 'value32' is used uninitialized [-Wuninitialized]

Part of the variable is indeed left uninitialised.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408062100.DWhN0CYH-lkp@intel.com/
Fixes: e769c67105d3 ("wifi: rtlwifi: Add rtl8192du/hw.{c,h}")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
Kalle and Ping-Ke,

Kernel 6.11 will be the first one to include this driver.
Should this patch go to the wireless tree?
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
index 700c6e2bcad1..ff458fb8514d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
@@ -181,11 +181,11 @@ static void _rtl92du_init_queue_reserved_page(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	u32 txqpagenum, txqpageunit;
 	u32 txqremainingpage;
+	u32 value32 = 0;
 	u32 numhq = 0;
 	u32 numlq = 0;
 	u32 numnq = 0;
 	u32 numpubq;
-	u32 value32;
 
 	if (rtlhal->macphymode != SINGLEMAC_SINGLEPHY) {
 		numpubq = NORMAL_PAGE_NUM_PUBQ_92D_DUAL_MAC;
-- 
2.45.2


