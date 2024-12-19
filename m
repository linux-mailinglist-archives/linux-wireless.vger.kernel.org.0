Return-Path: <linux-wireless+bounces-16585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996149F7977
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF94116AAA9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 10:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB8F221D8C;
	Thu, 19 Dec 2024 10:22:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2D23B0;
	Thu, 19 Dec 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603751; cv=none; b=XUJ+uotMp7CWT+MPPDSQp3uLuC+iv4jhMTEIU+XGwEB1pBYxTpf76Kf6/sRAYDPPKOHr1tPtpOohcq4OlqqT41TVpiE973ieLGytMvFmSBADyi/EEFnosiXPGqPjEDAhD4Fe6+4phGuwbEczSAZC2L0rqs//zZC304TqA887A5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603751; c=relaxed/simple;
	bh=Q1vu2km0mx5DPUIkc/keAR+NaxOGX5Rfy4+gaeJGYDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lm+hzAF0HflMZ6HYy9PRxJakfZKrITZnX6vNnGzEnbrzXq7kviomhqu7718KMQ3UScqjG8SVEjv9l2XYdXp5HU3H3Egkmf94dT5TMueJqHBLO5hz66RxEvWar8STQrx9y+Uqz2za8/T72WfjIUToVAh1R1Y6mL2A7vvOWkZWG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 59B7E6008C;
	Thu, 19 Dec 2024 11:22:26 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 wifi: iwlwifi: fix documentation about initial values in station table
Date: Thu, 19 Dec 2024 11:22:25 +0100
Message-ID: <2008554.usQuhbGJ8B@devpool47.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

The inverse value is stored in the table, make the documentation match the =
code.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wir=
eless/intel/iwlwifi/mvm/sta.h
index 4a3799ae7c18..dbc531c63f0f 100644
=2D-- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -133,7 +133,7 @@ struct iwl_mvm_vif;
  * and no TID data as this is also not needed.
  * One thing to note, is that these stations have an ID in the fw, but not
  * in mac80211. In order to "reserve" them a sta_id in %fw_id_to_mac_id
=2D * we fill ERR_PTR(EINVAL) in this mapping and all other dereferencing of
+ * we fill ERR_PTR(-EINVAL) in this mapping and all other dereferencing of
  * pointers from this mapping need to check that the value is not error
  * or NULL.
  *
=2D-=20
2.47.1


=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner



