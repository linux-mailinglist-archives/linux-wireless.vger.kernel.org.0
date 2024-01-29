Return-Path: <linux-wireless+bounces-2677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266B84129C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB828346B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFC676055;
	Mon, 29 Jan 2024 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VaOvqFiF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9937604D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553677; cv=none; b=ilhNmo+ALusIA0ZA4WPJ0DYw2ukZ/A2uAYJBUl7C91qYKr40tiahV1Q237y+hcOZxKqM6XZ6lUB/jfN8ForOs06pkanMa76sDZPzLFoW976xNdiS4THzjjtMXZy/rC3/tukRId6X6w0CKeNUleY0IzL9o0k/UZAEtwReVIkZpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553677; c=relaxed/simple;
	bh=FvuSfGGmYERZEj+9+F5cF8xO9eAJQmPOHg1dURcqzeA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q4Vz++htDE42tiDV8Ju8TpgBE5Ci8axWYhNFoUzr5hBLRc6P2YZg18OGKwpiHKrpyaO2VVEQqqij61LLWcVDTEiSv+JoXREP5KSZ4gtEQ4GwiaurQOajH1lrB6jrl5JBJzXzM39y3PZ9c1kFqtnfBDCyNt1lkp+1U7YRXd03xs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VaOvqFiF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=u4ffRVSQ/tECDMM6HAy2EvC4aYN/RaDEUEEyESi6y2s=; t=1706553674; x=1707763274; 
	b=VaOvqFiFzY/jJdfNdZ54ocyoUqP0zudiaw+k38IqtKQyFVaXp7hIzG6WIWJdG/1eHfx7Qn2UqqR
	0sNxMO9trTJx0VnyJD4PjR50QC3g6o8KHYvcz5kKghka6U+5DE4hYkE3WgFPieQGDv1YSe7UTWafT
	b3+kXlcLQ4xUDfk+o9o4DPkcSRQPqPOLEutVJs/LWlsck1Yww2E2ZtY2dNOPiQgEPK7ON8vJejzNh
	Jc0rlvlI+canQYMO3+DgxDemAwJpe2ey8KmvW3yauCH03bX0ZGR7s7UwGb9cWhAtEqlwg1/0qN2U1
	b2L0gTQ3OB2kMLfvv6U3sUyMw1w4X5oBJPwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZD-00000004z9N-1S2M
	for linux-wireless@vger.kernel.org;
	Mon, 29 Jan 2024 19:41:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: support wider-BW OFDMA and fix puncturing
Date: Mon, 29 Jan 2024 19:34:34 +0100
Message-ID: <20240129184108.49639-17-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EHT/802.11be introduced both wider-bandwidth OFDMA and puncturing,
and we forgot completely about the former, and misimplemented the
latter due to my wrong arguments.

As mentioned earlier, puncturing really should have been in the
chandef, which this moves it to.

Earlier, the series implements wider bandwidth OFDMA support in
mac80211, which requires tracking the AP channel as part of the
channel context, and then declaring them to be incompatible if
EHT is used on two interfaces (and thus there might be OFDMA) if
the AP bandwidth differs.

As part of the refactoring to more clearly determine both local
and AP mode (HT/VHT/HE/EHT) and channel configuration, this makes
mac80211 a bit more strict:
 - no longer accept channel switch when the mode changes
 - no longer use e.g. VHT if the HT channel inside of it
   occupies the wrong spot (e.g. center 40 MHz inside 80 MHz)
 - don't use EHT with bad puncturing (punctured subchannels
   cover subchannels that are used by HE)

Hopefully these things won't really break anything outside of
a handful of hostapd tests seem misconfigured (e.g

johannes


