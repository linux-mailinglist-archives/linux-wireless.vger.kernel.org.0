Return-Path: <linux-wireless+bounces-16801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00809FC748
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 02:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5034162BA4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 01:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA71DFE8;
	Thu, 26 Dec 2024 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TF46zbdN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22B1EF1D;
	Thu, 26 Dec 2024 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735175650; cv=none; b=mW2RKEkMoG2UiZ9ULBnE6vqZoWg83HRdocMt+bHPgteLM3v5gy37kKJHWOANypHbxdb+7neO3ejjuqEgIO9fVzwNa2f+aijk/E3Z5Cbq/UgFcw2dNcgThmdh+1VYYkv5h499erJv0Q2uyarUaI1CcT+i72RLj4Pkc6iW0rnpjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735175650; c=relaxed/simple;
	bh=x62kaEL2d8d/pF2rr5BgQ9Uwzz9yhvGQFfTGc5ML/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRZV63lNnekJeZ5ZyokvOHSER5VkArEFEFVJxanwDw6bKbj7tohtsY7PK9uTfS7p/W70K12vhSticRO6fkCv/kJHFCcOema66mmTPISBUmLn0jJqEItryGXYxHHILLcWTW/Mlx9dvWysx2AJwnRTRoGZR7ecZyYL9JeajeP6hCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TF46zbdN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=W2otBs3VW2czJqz4y/53YvPbxOWdLcAVRdUA42cNtzk=; b=TF46zbdNdiDBO2cF
	R3LYVJQLbTe1BgMZEu+D0RAHmnEMmRe3+t9JsNuUYKHTrcvq4B6RvKrLerBDWXAsBEQZM0hcLQvDF
	UHCBnMYeVz4ytlHKvyHRJf/6duYAr1bLI5Grznf3CvyTjKFj2VUuc565VarbFRCctU5eP+CrOk+/d
	cbqrroHa3OFMMjOCo2B/IRMqZJDKoafvjDDlblhFN7lNLd7ABYW/5gsc0mRnQ+aQ10pCyKr30li3w
	EdmktLU1buOG4GOfydlkxFVokvp4eQ/QAIzVUE8v0WuI0YuG2B09gBFmAFe+rtWaKqyZzBKhqbWXE
	0Uj1I8n0oKnHO5lVhw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQcRn-007EdY-2x;
	Thu, 26 Dec 2024 01:13:55 +0000
From: linux@treblig.org
To: stf_xl@wp.pl,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] wifi: iwlegacy: Deadcoded functions
Date: Thu, 26 Dec 2024 01:13:53 +0000
Message-ID: <20241226011355.135417-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A couple of functions in iwlegacy that have been unused
since 2010ish.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dr. David Alan Gilbert (2):
  wifi: iwlegacy: Remove unused il3945_calc_db_from_ratio
  wifi: iwlegacy: Remove unused il_get_single_channel_number

 .../net/wireless/intel/iwlegacy/3945-mac.c    | 38 -------------------
 drivers/net/wireless/intel/iwlegacy/3945.h    |  1 -
 drivers/net/wireless/intel/iwlegacy/common.c  | 31 ---------------
 drivers/net/wireless/intel/iwlegacy/common.h  |  1 -
 4 files changed, 71 deletions(-)

-- 
2.47.1


