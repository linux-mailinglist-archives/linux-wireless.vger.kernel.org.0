Return-Path: <linux-wireless+bounces-25469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AFEB059D0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA15F16BADA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C92DEA79;
	Tue, 15 Jul 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RQi+2h5o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E82DE71C
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581882; cv=none; b=UlDVBMw1Mp0I6+vJknQEpCNEHGC4mdlVO8Y9pTesSkE4Ka22b8T2b8en6U4esvtE8pawdOiV2ftWNzhhp1jdSp11aQDmfyqe7EFx4PbVQpBbaIQib/EA0o3ik9WxFA748n+dPUFiLVF5XBkwxnyGBQOOqwpGWfXzkt+vo8org8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581882; c=relaxed/simple;
	bh=dVIdupeHjO/K16TZ/WCn2TKYiXHg+uRqPq+j15ksV8M=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=sKt7zrRRM4G+NQYOMRI/wpN1ud2/4LlaP8t2nEDNgPyt4+TLMo0vZ0VsUbtqjXUZ7AmpCR/ughDKlB1PmOm43NmBgB7et7OFfti7sV8bZUg6Rxopu+fAnik1v22e4Clez8IKo0szaiQ9NZT3EtGkp+iBJ3hI283Hsk16HHVyUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RQi+2h5o; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=G2Fz2E5wrJCwA1/ITvMqF14e9EY38nAJgQsXA690sBo=; t=1752581880; x=1753791480; 
	b=RQi+2h5ogD4bqAfOeAgg/1bdros0WxsJb4pG0mbDo0+y2n1BuGQZhPG/WzxGGRLagXfhVCveVAI
	KY/H+TwYSIrSqFhJ5HsKzmJtabPaau2Y8bs3b9X+kux2shN0gvg9o2k3ke0wntx1IudJos6jJmAoP
	V6PYkGXHYCJ+WLCMpNgH00zf3siGvahzMLA6IHi+wKR67tdE3d5YWvlg5/dptkleAnZFlHPL2yQqz
	c4qWGBoBFZszgO+HaNBwWDVng0+MOrS9pRR8rHO+027aJulgaS4jlnQPDWuBISvNFCsmpbfn3Uz/V
	QcEK4iG9Gw876Bp4qabAbHSuRpf0y7oaumMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ubebW-000000064bT-0ws2;
	Tue, 15 Jul 2025 14:17:50 +0200
Message-ID: <aa29ba3015d533796516a1fcf8036aa1e0090624.camel@sipsolutions.net>
Subject: BPCC in per-STA profile in link reconfiguration response
From: Johannes Berg <johannes@sipsolutions.net>
To: Mohan Kumar G <mkumarg@qti.qualcomm.com>
Cc: Yuvarani V <yuvarani@qti.qualcomm.com>, Manish Dharanenthiran
	 <manish.dharanenthiran@oss.qualcomm.com>, Jouni Malinen <j@w1.fi>, 
	hostap@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Tue, 15 Jul 2025 14:17:49 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Jouni pointed out to me that mac80211 currently requires the BSS
Parameter Change Count in the (Re)Association response multi-link
element per-STA profile(s), and via sharing the code, also in Link
Reconfiguration response, as you note in hostap commit ce8a121287bf ("AP
MLD: Include BPCC only in (Re)Associtiation Response frames").


Also, as you note there, the spec seems to suggest this should not be
the case, per section 9.4.2.322.2.4, where it is only in (re)association
response frames.


However, in the spec it seems to be explicitly required in section
35.3.6.4:

      If the AP MLD accepts link additions for one or more links, it
      shall include [...] For each Per-STA Profile subelement included
      in the BSS Multi-Link Element, [...] and the STA Profile field
      corresponding to that AP shall be complete and consists of all the
      elements and fields that would be included in the STA Profile
      field for that AP in a Reassociation Response frame that includes
      the corresponding AP as a reported AP [...].

We had some discussion about this internally and think that this is
inconsistent in the spec, and also that the 35.3.6.4 text (that suggests
including the field) makes more sense, so we'd suggest clarifying the
spec in section 9.4.2.322.2.4.


It seems to me that your commit was more meant to fix the ML Probe
response (no disagreement here with that, I believe) than the Link
Reconfiguration response, so two questions:

 1) Did you actually look into the various texts about it and decide
    that despite the seeming spec inconsistency, it should _not_ be
    present in Link Reconfiguration responses? As I said above, we
    think it makes more sense to have it present.

 2) Are you aware of any APs that don't include it, which would mean
    regardless of that, mac80211 should accept both?

Thanks,
johannes

