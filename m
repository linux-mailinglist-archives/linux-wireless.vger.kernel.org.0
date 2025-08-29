Return-Path: <linux-wireless+bounces-26864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95147B3BB98
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F2A1C87C85
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4314884C;
	Fri, 29 Aug 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8m+6EET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA94EEDE
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471715; cv=none; b=e6RCgHe+hEA87Nf9dRxSfXHYX3lapz5HAltJnhthXMHAu8ezfsKv7dvFxZw7fJ86ei2uyeH5LqAzMTQraJQwaTzRe6TtJhcJ5XOiyHc4sO0h9pt6RcnCbfskHi8rmhYzq8Hf4YqY689r0h5kig8rfePLUlmN9kRkOfAeO0//Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471715; c=relaxed/simple;
	bh=PfM+wt4euQRDG6Ic7JsVFJRNm83TNiaN/c0Z+WZKFlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU6Vb/RuWbsYUFM0hOi21bak7GKxl3YKDkpb4HOhiozOvKYvcTo2oR6iTF+3cAshTs1PDLGQE83Cgi9Mu/SpK+KI4JAyuAJlHD7IeLPhoHpptCWrUBXnS75h7I3ECbP9rsBMBjWwupe4D7a6X0D6HsPq9KbxoY1d0riDpLl2Kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8m+6EET; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3d0dd9c9229so433005f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756471712; x=1757076512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTM2+VDKikHtSeaCiymICMXcXjx2xNcBiPL91bhKQr0=;
        b=A8m+6EETCukGWs21sDBCad6TupbQKbf8Rfc6aQhFQmN2ozdj3kOOYF6KrJjSCoSCjC
         ZvSQ5Hd94xrtz4VeRUhwgIHmz1n5ifx8OzeJNw9QUUWQIt+4a+MSSD1o0GNa/RAQ4MHU
         4Fww5dzYZqVU9iDpjsLOZoEfkM7beHxT1UihhTiieP4aL6L5VpOf+eqWVk/oDOXmLixq
         /1KP0WnHJlOqShiqITDDbmgQSureHKiVQSz4z1yCN5kZsA/GrbEBxv751at1sDTqKKlj
         S5w+Xq683qpjRxSHyqLYiZ/aHkebOVd5WTg7eBJ2XJI+RtfR4Y12m88RYdP1Iei45mgn
         g3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471712; x=1757076512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTM2+VDKikHtSeaCiymICMXcXjx2xNcBiPL91bhKQr0=;
        b=D3jR6uRuxOwgRD+LgcRBVbGQgxbb1bst0WziqawxJKDS97K+tPdJ3fYQqcM2onTU3U
         vRPe3iJ6nivVjgv+p9fdEs8DrxzmgReoH3lnrXTZd6QEsb7Bj9YwXh7bUDRUGztmt5Nw
         NJF/Qv6BVQitXIMHtGybV0sExI5e5CO6YuedzyY80tiUlvQO395iQDX9jb8Szxj59J6u
         MVuzHFTRDXRlhSe2ooiDGtvVEXy0lyT9SlK8kxqV48KtyfLjjw2j0mHSITSkJk6arewU
         hA/t7fsgfWgZa2v4QHsPBn2jflDqA1M+NRUEw1NXXhTAdLUAN44L+ddafboHFlIAuw9n
         8bXw==
X-Forwarded-Encrypted: i=1; AJvYcCW3QDHNOXk7x2BMfUo9mcryhnxJU/b7tLtrB3YR4a/HVfO7H+upXUtGDcme7R67AuVE/7OJrkobqRmuhyK//g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67nUhVf90dsOkSZVoMUTa6sExNAc4e9PEcZWPadhjYxSO7uM9
	eI2uEBkw196ghyn0jEJlF0CBTFUYOGYPGOE6OU9mBfaZzTmXlF9npOLNQjYmus1cLtI=
X-Gm-Gg: ASbGncvIEG2v87EVb8ABvOyU4WIBhalsCXGULqsXZNJXsWWeejW4OmMMRuTxgE+h2H/
	SkrCiW3SJQxru3uSdstnIcDwds59ZDNhTPHXjXBhQaMLFysma0GQ7ptlh4VTfu2BAcWJDxykTwp
	MgjZfuuyp6+sO/EWYXc0KSFaIw5w2jyGkEmvC6AK0BvKhm3baQJE349MxIobdz2kuuV0bONZuku
	dRN5BLV3280FN/lyTZNHNeaUvckPHze735bs6dtde05aFx8BSNJ2TwzldOcDRUV/6AQs1za1gE6
	48zIbbnUDWc+CjXIlWjmcR9HCwAqWIW8f5nUTBX6dg3rN3DQMr1KGRLqLqtisC38I/2rmfIMnnj
	XY70y2T2L7jUR8Rw1LmFFqwzlzHs=
X-Google-Smtp-Source: AGHT+IEt7FoZ+poRNkadPvFS4MiTQw46m2z3gSirCmxuvzO0nDj/MLzNGlzo9GuQ50LaspKQ2QDy4A==
X-Received: by 2002:a5d:5d0b:0:b0:3cd:edee:c7f1 with SMTP id ffacd0b85a97d-3cdedeecb38mr5773224f8f.56.1756471712413;
        Fri, 29 Aug 2025 05:48:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf270fbd01sm3392325f8f.13.2025.08.29.05.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:48:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:48:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Solomon Peachy <pizza@shaftnet.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] wifi: cw1200: cap SSID length in cw1200_do_join()
Message-ID: <e91fb43fcedc4893b604dfb973131661510901a7.1756456951.git.dan.carpenter@linaro.org>
References: <cover.1756456951.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756456951.git.dan.carpenter@linaro.org>

If the ssidie[1] length is more that 32 it leads to memory corruption.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/st/cw1200/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index b1dd76e8aecb..5d8eaa700779 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1291,7 +1291,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 		rcu_read_lock();
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
 		if (ssidie) {
-			join.ssid_len = ssidie[1];
+			join.ssid_len = min(ssidie[1], IEEE80211_MAX_SSID_LEN);
 			memcpy(join.ssid, &ssidie[2], join.ssid_len);
 		}
 		rcu_read_unlock();
-- 
2.47.2


