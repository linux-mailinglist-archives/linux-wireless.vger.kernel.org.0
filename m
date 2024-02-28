Return-Path: <linux-wireless+bounces-4144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D5186AA65
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D811C20EFA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423562D052;
	Wed, 28 Feb 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VM0w4hCU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2C1F608
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110148; cv=none; b=AcAqSgtwpNoetCVwcdrs55HtwYSO+N1vWUa9NHuR0wSC6q6zcBbttEucZ9ziUToxCgL5MOdmyG6tgk8kVTdaAB9ASE744MY+WU9dcTPlVD77eQpKDk+LF+2LN/E2x7My/5hvvTztOjcbPPk1eA6uMGwvI19anWGX6AEgMzMbeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110148; c=relaxed/simple;
	bh=756ARI+CGcugO4QXBzDhLYnW8LfaKi+guBQG9KedS5Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LOJlTc3tZyTNAfUr+p4cPntAR677sreCuSdHv6jWxUTPDCdgkRjHMgMdmAhtUj/EYv0vvqk1xMsjHMSV5HfbIGKJ5kul8xKx6ylkAVH85h3Dq0QGyyqxKCOtN9Dg6YWWSlCAt9lXWUuZusiwoYzzP8ZPyC4jZfmg3UJeTUS+laM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VM0w4hCU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=756ARI+CGcugO4QXBzDhLYnW8LfaKi+guBQG9KedS5Y=; t=1709110146; x=1710319746; 
	b=VM0w4hCUBZLkfyZDAnzh3EZTOPdOgqkMVH/nio1BSvd7u8llbs1wYRZJ0fElUB+01O59d5rzULS
	0RKreSKZgunAjzTPfgB2OdQS60EOrilITckppIeBOqHqcJEuDu87m/TW2UVIAQnm3a1R3MPZWnQc+
	fqvJFCOYMNP2CkZIWSAh/ns1QM2YeEEc2Y9vgX0Q/aT0IgZHEuOobVSA3TUpiXiSOPNnsYX104yhM
	ze4CtwuzMFU6lmI2rmj/VO0sNJ0ZCv7loFFK1P09daPobPa6x8wGqcVa1+XMKriONU5LJoMeTF2UA
	cc2S5YQ6hgvHCgCieWgpykuXLiOV1hGyWXWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFce-0000000C0BC-29LZ
	for linux-wireless@vger.kernel.org;
	Wed, 28 Feb 2024 09:49:04 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] wifi: mac80211: element parsing cleanups
Date: Wed, 28 Feb 2024 09:48:08 +0100
Message-ID: <20240228084901.18661-10-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some small issues in how element parsing works, and
I'm going to reuse it a bit differently for CSA. But before,
clean it up a bit, and in particular hide the scratch buffer,
which was used oddly in a few places.

johannes


