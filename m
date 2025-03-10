Return-Path: <linux-wireless+bounces-20111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C67EA59751
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 15:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD32916C24D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D034422A4C3;
	Mon, 10 Mar 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+/0KZ9i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D922B5B6;
	Mon, 10 Mar 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616185; cv=none; b=dmJhdb0IDtiXrp9kXbA/o4QbXOhRGmQN78r/Owj+Xkh/IZBEiM4cYQjeSsEpOFwd++zjoaZbfbu9pMgBIXUQECd5HfhdzCPJw7QZVXHdRsjkTC2mr4LizhcP2+Mz3rNjnvTz3YPZjwqsSyjWDrtRyzeMaP61H1gdTc3QzPfgjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616185; c=relaxed/simple;
	bh=2dSebWRuPJTUB45SrVW2KKIGck6aWcSHUgcwqRikNog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YSq5TXcewivURJyry8TbqKDluU9I1/Cq8KRY3K6drBCVmuy9mu2WRVVjy+8c+VD7NVwo6Qys2/jqIr1Va3qT2mI4eJGx9cYyIp+FF5Z6R9kpzrW/vfaLrs7wH4ht1+EFSNR7Xre6iMSvBrottWNGBXWNKXHwdesNcrts0orU7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+/0KZ9i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22423adf751so59361315ad.2;
        Mon, 10 Mar 2025 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741616183; x=1742220983; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwQv6TuGx9vxNTr7ThxKtvNtNQNQuCBCeSGuS/Ah7kM=;
        b=Q+/0KZ9iWnYEyDf9XZSaC0CJEMUdPJsXaa38fmRYOIePwTbvNzEWGm5kg+Z30rcBFZ
         V++fd9wUJf9sgHhp2/cbVLtFDeyAD9bJMewEO5Y1JGGDLwkm0VZyl5mrqF37yjA4iSnL
         ONEyps71S0Na46zOLpbEUk0dedh9J0+Fy+5ejVKtR74Zrm1uckezwvcwvYs5dAE64q4a
         8w9JvN7+vyv70ga2AnA8JPZ/128/NpuMAIHHXkp5qcGY96XOF9WQhZDYH2HrTjYsCXB9
         7mE239hcJfEF6WsxblzSia9YMk6Z5qi4BvYFHiMTIMvs3QO8SldEp0iViVlqClxUKhhb
         OWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616183; x=1742220983;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwQv6TuGx9vxNTr7ThxKtvNtNQNQuCBCeSGuS/Ah7kM=;
        b=Ltp2KUQ8k/sTcy7Faq5f1UP19Aofyx/wcojyUywK7B3lI9N6kknHHaiatOlLLuTsXp
         uM+i2DjJhFUuIzuDDmVjCh740q2tGoOCO9rI9eQXg2JIql/ADD+KoeZwk15bxw/+rrhx
         6EkkI89JWya8rWmxugGud4F9+Kq6duMcLvmzQnDPn/A1kO+y5rlixNge2+qtt3YmfY+b
         rQrOlbg7iiOPg+H4eqNUSiuEAspBB0jpglHr1kl0A1BWyOIlulnZwzY6xIdfAWaYrVz5
         GJ0I3RTlThn+dQu1ve1/WVpBdQrbMEhXEqcLAfFoDSE3OKeiWzttv2sdEW0DSsRVng3v
         ex7w==
X-Gm-Message-State: AOJu0Yx9UmWM2UetC5Q+pa3qVJAAFTYxjFhphzBzMOYOWSNIFfYAfOac
	ldvfnjmC8VoRb3w9Bw8DwxRinvPXsqmdvjIhwqGBV4sr1apNlvyV90sSMw==
X-Gm-Gg: ASbGnctcaL8/WMg4bjvME5SniBTvU+0DXpHuMFj470ATWEtDlRwkUIw4YL2ecl5jMEf
	g8peUQ1S1BmuJxX6xgntyhc78ndOwm1rkkXncnIItPtkry3vdKjCWNxHrsVU2Pe5IGhWP0Wepur
	+ucr40ty0kQ/m1/CtlO/1In/0ob9QQJZ/iT5PCMFfwyTmRGTdwkyEKp6tKxr0Rq7EFUiWv5LvCR
	4zHdUMQvdBPpKGzDwJZ9FrBLl7Iq4vV23TqL37Z9GNuwBQX47eDys1hwKogB6Lhkff1uZHrboxA
	PFK7FgIv9ilvRxabEXGdSgqpdQKNrMDBDGSZ88I+mqG6R44=
X-Google-Smtp-Source: AGHT+IFiDclXx6Zc3RzJ+ThsxsojtpZJDy/BegzJ8asrbtKDLpfeDFn/S6sOnYfiGgiagiH4iwtXdQ==
X-Received: by 2002:a17:902:e842:b0:224:26fd:82e5 with SMTP id d9443c01a7336-225931ad6e5mr279325ad.48.1741616183086;
        Mon, 10 Mar 2025 07:16:23 -0700 (PDT)
Received: from gmail.com ([103.210.134.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa4e94sm78290415ad.221.2025.03.10.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:16:22 -0700 (PDT)
Date: Mon, 10 Mar 2025 19:46:16 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-wireless@vger.kernel.org, johannes.berg@intel.com, 
	ilan.peer@intel.com, miriam.rachel.korenblit@intel.com
Subject: Possible Null pointer dereferences in net/mac80211/parse.c
Message-ID: <qriquzbudggauxqm5oz55zvkh3uhpk5icx6icnacyzzijdtivr@m37pbcwiqblb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Coverity Scan reports that there might be a possible NULL pointer
dereferences in net/mac80211/parse.c: 1061 in
ieee802_11_parse_elems_full(). I understand that these reports are not
always correct.

I'm not sure whether the syntax
struct ieee80211_elems_parse_params sub = {};
is correct or falls under C11 standard[0].

initializer:
         assignment-expression
         { initializer-list }
         { initializer-list , }
initializer-list:
         designation(opt) initializer
         initializer-list , designation(opt) initializer

I'm aware that C23 allows empty initialization[1].

braced-initializer:
                    { }
                    { initializer-list }
                    { initializer-list , }

Considering [0], if we do something like

--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -997,7 +997,7 @@ ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
-       struct ieee80211_elems_parse_params sub = {};
+       struct ieee80211_elems_parse_params sub = { 0 };
        struct ieee80211_elems_parse *elems_parse;
        const struct element *non_inherit = NULL;
        struct ieee802_11_elems *elems;

Would it be incorrect? Would appreciate some feedback.

[0]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf
[1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
-- 
Regards,
Brahmajit

