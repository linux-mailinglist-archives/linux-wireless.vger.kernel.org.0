Return-Path: <linux-wireless+bounces-25358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E1B03B41
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 11:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1477B166B55
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347F023909F;
	Mon, 14 Jul 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="H+DWqyEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60D218AA0;
	Mon, 14 Jul 2025 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486373; cv=none; b=POP2xr3Y/OT/6CvoNY6IbOromRkww+hdHbeZP9+PxWOWQ8IvV6JZGyS9dHX7wb3LB9Byu5/9hlt8kSqTbNHgk1sBnJJ9wF/i+5XHuol9RpxI9W6l0YNfPxjrasCmM9RvjUYZ5D3El8JAngbxAhN/+FqLmgdGhg9DTfFZOHaF6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486373; c=relaxed/simple;
	bh=3en/F3Q6Ei945LGNZ64Ifdb7jN+jYooDwO5SqIhJ1SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upaw2RslaVad9YVHyaDaEY0IIcDKrhkIiaZhFpmrYUXoANZvJhqkuWcQ18hpvd0mrrSMI3fpzIguZ3ILsnCbxG9VbL0KNzq2ye+bpmi7yV1hDR3LFZ3i7SAI3RW6g+964w9p4TQM5BunI39yX0uwUZ3E41xYQj40fcGw/p/XiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=H+DWqyEs; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752486338;
	bh=S4+EOTzh9hIQdp0CyIctQMlGIN0l3KlBQMuD+Hs9ZQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=H+DWqyEsJyx7yEc08nO8VzZB3wTP6qnN/1hqpjhQMmLz4j5oGaNH01hngDCAb1p4X
	 2JM0X4InKHQSSxPNJb+W77anbfsZf1MvTR/rzEMRcyTzc88sFOPhdHJdM0rA+JDlGg
	 r1AkucXY1jJ6+Bh72viie0Mx/rqJfocG564LrzUg=
X-QQ-mid: zesmtpip4t1752486326t80ffebb7
X-QQ-Originating-IP: LmPXaHjx1X8amsH0wlJdpnh53bWafD8NNmtoIdzxwJU=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 17:45:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12365466882182443357
EX-QQ-RecipientCnt: 7
From: WangYuli <wangyuli@uniontech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] wifi: mac80211: warn on insufficient antennas for injected HT frames
Date: Mon, 14 Jul 2025 17:44:56 +0800
Message-ID: <53AD760311F904D0+20250714094456.259784-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OW3qjH3bC/TA7ZL2Z5NH3TVrANB5Evb24xKSwrfGSFCZ0Rdie9PW3vhQ
	ptIH+1UOpSNSldxYLnMHPdy/77xDeliS49Cjf5OCQ0wCy8AA/yEuGhZscgSGYwvRAFau7wk
	GqoumRasZlJ75DKEE/qgiA3It1ppgQ3afSaO7juBO4O9hYO4SQbldAFDFwDvcgbbewCcIyQ
	OvBUnsuKILMGH9dX7gN5jgkB6qLUTdTWY8ynLM+ZspdEZfOgQeUzqU3jJoPC+sjxeuT3NBy
	NJI1sgZDOb6sQvKYhETmsiBjFr7dfjLPJiaJshbJhisPOiIO00ZxCo9dYmmy2/B3/17Yfim
	Nl66IqK50c8pQ7bnflOEozjfcqT6/fISuW9f/25lDZ6zqioLUqFHr+xjzHnhcBgnrRgZfSH
	pDd0vb/TJCjwpACX+tgWoz6TDSlcZKWU7Mx0oGOvzVSMmPbAcq2V5YK2Wo3/cErWHV3i0uh
	sHvIC0OFjoQosonvkZLN3+9z0SZ/h88ghugvBBuDshH+AMUuGjUPWBFuMD59QAZ4qNn15QE
	D5d1l2r9ID67HvU5Fu+eCHNg8Kyz8MyF/APbTDjnDdlNVKTZv6nPlaO2TmpIOhFshqgNjRl
	Ya4Y8quTfCNDUyzAR6qVp0T2Zne7/eMf968iNWKkkavZ3fMcL/C9QX3En4Kt08pKWDf6mJZ
	mhkLYKvUFkg9iDBR2h7LpyV2/CPVi/2uqIoCJnxDTlDI1F2J33w6+2V+leDN9Mt7jswJgBu
	dF2mZgA6KgMT6DgsE+lRg+7eHrefPdjpdP0M6eJwGNynUo+RNMfK6UXoAMNObnwj8skcIlj
	0piLEt29OeHhvG87P/FtIHD8/pTmpgKoKmKPb2T8FGJSssAG1CHvfRe9zk+cTmjGMq0trqr
	karertfXlPz5OQelgUNg8yz6FcuJgNbTDFChcicbgF7aC2aqRMiEdhSYPfuZL6433zotVlv
	9k/mD4y9WvFD2/yDfBc0OIGB/SS8t/B+QIc/0N6DcTV+vgqETxxoCgnfYTlasLc7EhM3JZu
	1RVy3rq9HcezO2nML2UUvjnV7Kkqc=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

When injecting frames via radiotap, an HT MCS rate can be specified.
The number of chains for that MCS implies a minimum number of
antennas that must be enabled in the antenna bitmap. Previously,
if the antenna bitmap specified fewer antennas than required by the
MCS, the bitmap was silently cleared. This makes it hard to debug
issues with injected frames.

Add a WARN_ONCE() to log a descriptive error when this happens, make
it clear that the antenna configuration was insufficient and has
been reset.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 net/mac80211/tx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d58b80813bdd..e1464ef7397d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2251,14 +2251,21 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
 		if (rate_flags & IEEE80211_TX_RC_MCS) {
 			/* reset antennas if not enough */
 			if (IEEE80211_HT_MCS_CHAINS(rate) >
-					hweight8(info->control.antennas))
+					hweight8(info->control.antennas)) {
+				WARN_ONCE(1, "Not enough antennas set for HT MCS chains (required: %d, set: %d), resetting antennas bitmap to 0\n",
+					  IEEE80211_HT_MCS_CHAINS(rate),
+					  hweight8(info->control.antennas));
 				info->control.antennas = 0;
+			}
 
 			info->control.rates[0].idx = rate;
 		} else if (rate_flags & IEEE80211_TX_RC_VHT_MCS) {
 			/* reset antennas if not enough */
-			if (vht_nss > hweight8(info->control.antennas))
+			if (vht_nss > hweight8(info->control.antennas)) {
+				WARN_ONCE(1, "Not enough antennas set for VHT MCS chains (required: %d, set: %d), resetting antennas bitmap to 0\n",
+					  vht_nss, hweight8(info->control.antennas));
 				info->control.antennas = 0;
+			}
 
 			ieee80211_rate_set_vht(info->control.rates, vht_mcs,
 					       vht_nss);
-- 
2.50.0


