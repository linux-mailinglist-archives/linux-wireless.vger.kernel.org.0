Return-Path: <linux-wireless+bounces-33040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G0HIQ5IsmlrLAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:58:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE5B26D3FC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 731AB3068EEE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 04:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191839448E;
	Thu, 12 Mar 2026 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="1iW/brzU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2701DDC28
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291515; cv=none; b=iZAwuUp9pGOHdCakWeqn916zJxElmDiqpyilXqfiLPtmJrWgk2TvlEw11ZOhg5h+m6RzWj30lAPdPWR4VJDM+6vfzWwAecjxbZuavbl+Ww9FwHVfz/Y2KenvUks8OOGJxpfT9whwPFke4etqLOnPhPpgbXz/d3OM/Ec+R+Yy4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291515; c=relaxed/simple;
	bh=DfoX3xRuwjDkNQcWCr/viDg+VrK4ykAeJ/C5L7LNHGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ5RatIC6mqalEXADLssFNX8lerXhEwJZg80dy1QbDfXINx4m75iRa+T4wJ9DsqnRX1BQq1oiyK7PngPlFljd0JGBHg7RBdn3hDo2q1one2m8oq4eNO2t1wM7bAK1y0/n/X90eOFIBF9tXCQ1oiIV8VrYlybdCNOTHMlrucPJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=1iW/brzU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-829a9d08644so344517b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 21:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1773291514; x=1773896314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MPVl4RZBOAZ+VFzM10dOCBFqjg/4eS3gTU3WdTxdgM=;
        b=1iW/brzU9moKajf5NGn76ppxqxxb5qje3HUfpV55L/e0B8IvYSdhOQGJFqdelk0apf
         saoMb+KEmsx/g03NHkmGmDYDhxkG7Wf2CHUqp0BYe3mxYrZAFv47nrlq9kYO66wbufYH
         Dw+LMRj7e+PL2cPql6GoQTIiD8q5nCDjU6afQr7W5yWi6q0Bxki9v8JNptrIAkPfJwxS
         wr3UpTFvEXMJbbqq8HDa0ILoVIysxYXZ2atyEvqJ60sIRVoqJYT8h7ZLw5AAu7xOsGmR
         X6e8h9rwoJvGFG567UmodUpqr451nUnimCAr/fDScVCT2XdWFeztI8lOmexTy0vGfuaG
         +RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291514; x=1773896314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0MPVl4RZBOAZ+VFzM10dOCBFqjg/4eS3gTU3WdTxdgM=;
        b=h2Usl4Ryj2RjLaaRl8mvOvbADjU/HXyIdkj7+tHL4XUOlqJUFe+uPrQ7t6lfqQ/uSB
         nr/0ROrAb8k4Kyg4BMiiVm6gBAUxtMHas5CG9mpndSfbU6M0bDVUQyXf5uuFSUvBmf9G
         kQHQHoGsRuwxyHryk1Is5UmTIYGkcPZj+3+cNW4niC+WQvdYqTtuIAzEh6rLImDqcL+1
         4534ZGmKP5JMjYfW7mJrFiNpE94nzdcypczyj9+osTfKc3n/U8YJyToaZHjKFb8kt9F1
         DCA/fama9hMd+WuvWSPQgf+yuxySdddPYC0FnPoxPN2BbPu+kYBKn8ffKvDRulgvjDhj
         C0HA==
X-Gm-Message-State: AOJu0Yw3AewW6gfuK2d93s8k5m5Me42H+BQLqO1Hy+EmcvxVat1dDvCV
	V46Rs+jTQoVPBR9qPBQ5OLCA1p8B7jiiyzowQ16Pzlo48fVy66bA1eMgxmJflrMn6cI=
X-Gm-Gg: ATEYQzxwcB3AfNEXkjJ3pvvWO7XBziLqLtcUvpUatMcvBcovq5DaTF5mrX2cwmhaYK0
	esrPkF8QIsjEqy/hTnn3/O26qgQPSxN1+b4KTZ+Zii+KwMQkDw6GTBlrM/DxiilMxdLSSuGUhXE
	TmB+qV3KReIM7k9NukqKjK8RxEFt/oXqBvjW2/LCLN6VT3jSSF4MuqZ7hLl80Arkqc3EDHn2yXv
	qm+Uo6YXgPAlmq8QUqCOB5vjr+9Qb0IqpIo6riJFYRK6G4dDE1OvH/iQI8Ldiyx/rDApvBn/8iO
	aBGsBvv9K/Nob1k1l9aVUXM0v/5Kd6CXM3BkNyo79Dd5lERNgw4JPZP1chPpuRjviRrJfXp7BAQ
	YjrnALTpMwus69VAhEkfc0wCR5V6wQYuy9SXkmnAIwrF0pHwOkZqcG7ZxB6gWWOVS3Wl+FoNMk2
	mBHyFQsU3PGENmD3Pki15sVpJl93gnhkMsABkfOxDXrpvGZS1jX5RAb50pZFXMYMbraGzUpiQG2
	61A4Onc2Hu9DOqpRH8aOsx0XP4tgRA=
X-Received: by 2002:a05:6a00:8009:b0:81f:4f05:4fe6 with SMTP id d2e1a72fcca58-829f6e71412mr4644861b3a.1.1773291513680;
        Wed, 11 Mar 2026 21:58:33 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365090sm1382480b3a.46.2026.03.11.21.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:58:33 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v3 2/3] wifi: cfg80211: restrict cfg80211_chandef_create() to only HT-based bands
Date: Thu, 12 Mar 2026 15:58:03 +1100
Message-ID: <20260312045804.362974-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
References: <20260312045804.362974-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33040-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim,morsemicro.com:email,morsemicro.com:mid,sipsolutions.net:email]
X-Rspamd-Queue-Id: ECE5B26D3FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cfg80211_chandef_create() should only be used by bands that are
HT-based and the chantype argument makes sense. Insert a WARN such
that it isn't used on 60GHz and S1GHz bands and to catch any
potential existing uses by those bands.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/wireless/chan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..4d2c2b9f1eed 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -29,9 +29,11 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 
 	*chandef = (struct cfg80211_chan_def) {
 		.chan = chan,
-		.freq1_offset = chan->freq_offset,
 	};
 
+	WARN_ON(chan->band == NL80211_BAND_60GHZ ||
+		chan->band == NL80211_BAND_S1GHZ);
+
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
 		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-- 
2.43.0


