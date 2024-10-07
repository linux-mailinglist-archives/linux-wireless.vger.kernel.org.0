Return-Path: <linux-wireless+bounces-13630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929399362A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ADCD1C227B8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B51DD54A;
	Mon,  7 Oct 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BsNdFI38"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EB132111;
	Mon,  7 Oct 2024 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325632; cv=none; b=tjZNlvN8Jbvsk4tpwUnGa5XnGcorrlQJxyOFKLSQNUzsN/jr98qU5M2LaKo8lGvLDLh9n63dtG/u1kZdN6ZC4R+sgw6FpTEsxhnry4HBfq/XoUUDhfBQsUBDsF29LyNGHG2DShUmSn+M5rLD3Qwp+OHG8l5q+hT2v3I0EL5u0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325632; c=relaxed/simple;
	bh=jxj4UOMtKurVrXybVfMkRFUGISJC4/il9q1tVBYnJbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rESBsvGn6JILvET6OSMpQIYdnI5mAkQpFr6c3yVzlu74pijnZQyj1j3Hr+3JECTQdKMypop8WT64ai+991viiorwzWtetQaB5EyJ+iFZI8SSAaBfTIWA2sdzLdILjPQ7dLRIxF0y05RUDQ2VkcNS1WBCgv/IZNHUXIG2Bh6SToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BsNdFI38; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=jxj4UOMtKurVrXybVfMkRFUGISJC4/il9q1tVBYnJbM=; t=1728325631; x=1729535231; 
	b=BsNdFI38pIz6DB9h2gGuJnLOVCieR104RyNM+m5FgVa4x4Mf5Uk3BLNqSx35nULtLEJxw8FUnPV
	US61ZP2rV8/+Pa7ONfGvo1fJwhpZYeGuCabZk4kRSYIpRlKsKMiX48qIExpAhrClO6K3JfqxoAYYt
	uwgKG1X1MrPiUHOAdiftgsVunV8vM9vxh67Vk69UlF4/6ohhVR8cZfOuCZTOhuntO43P3Bl/ozwkA
	9DeTo92sboOR0vP9o/kLmM4s+Vj6o5K5NhXq218N4OODlQWlp67QmCTv9CjQOv0sHppCPZxn+mIdK
	Y+CLMyEdO2X5u6H+4UMo9gQmAIKUqtDWf1Ng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsRp-00000003U6n-0ahT;
	Mon, 07 Oct 2024 20:27:09 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 0/6] lib80211 cleanup
Date: Mon,  7 Oct 2024 20:26:50 +0200
Message-ID: <20241007182706.66888-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the immediate resend, I had missed some spots and
saw them just now, hopefully nobody looked at v1 yet.

johannes


