Return-Path: <linux-wireless+bounces-6570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C81298AAF72
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 15:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B41F23C7C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBD128811;
	Fri, 19 Apr 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsEi5DnS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32BC12837C
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533733; cv=none; b=dCAVPfAq14kQ7PlHHO35NZCqwCDftay8HOKV/xs8XVjgKXbPsc3jenTWeqqSfq6rlWu/2SVtHMUqZL4evoGWCtZtepPc4UKDzduQVkH9qDnsGGM4y3dm89Mu0+lweUijEwc75M4fcLz142omVBykElkZvJfBVCzRhvXnRgPWE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533733; c=relaxed/simple;
	bh=6s/Rmiu2USiiXFlqpX9fg8GbZb5efJl6r2wvvHiDilc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T2MYyC4QQ6vlZSDTSI9HUtIx0/MJL8VlfAfH2xRDe8csO6vHmb8nJEb3iJTxo3M125SEwLdTzRznqp6wPT6UveWUKv55/CVdnj4QzWvV+lfPqaDd1gejyzR7i+47Cj7Aoao+9W9mxF2x+astnCweaEX4tDAXISeNEA60cqytOyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsEi5DnS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-571e1744893so122198a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713533730; x=1714138530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gBljUc3bw1ZS7D54uJZ73TdtHGyoEfUNbBgUPCRQMwU=;
        b=ZsEi5DnSfgh1WNjFXvD0UA9NmlyAjq8dvNbw5LDQLrHuZVtuH7oL5zHCNkNSxRMwZW
         ZtSf4S5bYXg/dtFOPWhh6C6hr6sAovFQl2HSmEW1TlNr8rBHNwT1fc3y47SFYM9wtHLP
         uio+iMgoKBtfxkXcwcuLYpCD9qirpk56N3YjgEM7llR35zOucw2z0wJZEMorLxWKN5rb
         A3A+/YCBNrnvsA1vxiOA55e2wUY9h8O4ecnpILpAWQw5gjDTxUz4tDUo3OCjI86QXQn5
         QWl0wd2n7vHAkM6cEqjwOUgznej1NGl/J/6ccCyTDmS7ZcSHARuqIUMtsORYqqXKMuba
         mm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533730; x=1714138530;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBljUc3bw1ZS7D54uJZ73TdtHGyoEfUNbBgUPCRQMwU=;
        b=WFoEa97Sx1oicqjD0+7UWf7nKNfsvAs8sRwlstL9ZsDF1iKkZJA2TP6K9UKS32kgiQ
         vH5lWOgp8XZw0wKyNmBzUEo0zUtXAEjZC9f4DcCob8PG3z7MTXTatE123cYqPWA9c7p7
         RJYJEaas1XN3Ww9iELoV6tTOdsiA6+pSjvO/h4kf8b6iXizhB/KdcfAoNXX81I4NPASz
         HosdTcAq+1FgY3khL/4gm3k2r6kZ/+FWn0gHJkX8RIfNtGyu179azuqQur3fcWgK33iV
         7ZfCsxlBN1DheTHSFaNMyuSg6XjZP6Ja6gemCkfDgCGx2HVa366NORq0Wr0jHuEFvC1s
         Nbdw==
X-Gm-Message-State: AOJu0YzLRq01Dlw6ll9fpkKcSz5I/WWlclYRYxpC0jc+VNI/f4uYd/H7
	5orE9dfzwZfQBOFyVrDnpHTvK5Tb6ovEtDUL5zaQfivfzOgcgs3X17igPmk7
X-Google-Smtp-Source: AGHT+IG7SXwtLTugY7842HGQhs3nPcRK0ghSrX7fTKAzkm+lII6054HvzvA8caAKBOMD6ipFov+q+Q==
X-Received: by 2002:a50:cdc4:0:b0:56c:24e6:ca7e with SMTP id h4-20020a50cdc4000000b0056c24e6ca7emr1418084edj.2.1713533729672;
        Fri, 19 Apr 2024 06:35:29 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402089300b0057016d010f9sm2119828edy.16.2024.04.19.06.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:35:29 -0700 (PDT)
Message-ID: <52548427-02c2-4871-89af-d72b64798b08@gmail.com>
Date: Fri, 19 Apr 2024 16:35:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 1/6] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
Content-Language: en-US
In-Reply-To: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Different channels have different TX power settings. rtl8192de is using
the TX power setting from the wrong channel in the 5 GHz band because
_rtl92c_phy_get_rightchnlplace expects an array which includes all the
channel numbers, but it's using an array which includes only the 5 GHz
channel numbers.

Use the array channel_all (defined in rtl8192de/phy.c) instead of
the incorrect channel5g (defined in core.c).

Tested only with rtl8192du, which will use the same TX power code.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v6:
 - No change.

v5:
 - No change.

v4:
 - CC stable.

v3:
 - No change.

v2:
 - No change from v1, which was originally sent separately:
https://lore.kernel.org/linux-wireless/9995b805-ef8b-47c9-b176-ff540066039a@gmail.com/
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d835a27429f0..56b5cd032a9a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,8 +892,8 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel5g); place++) {
-			if (channel5g[place] == chnl) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
 				place++;
 				break;
 			}
-- 
2.44.0



