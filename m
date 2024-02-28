Return-Path: <linux-wireless+bounces-4137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A597686AA4A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FDDB25BA1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135C2D610;
	Wed, 28 Feb 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IwiW26N7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95142D044
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109736; cv=none; b=aPQHh4mQyn0MyCRDideYdO3WiY1ijWcAYvTD5eFpf+dvdiQRSlpOYHGJeuhZJpuWThjiDRblH8ZQyU29JOrlZRI59gzEnsbRG0P1zVs8nV06tp0IwdcD1mjK0WBy/oFmFa+O2Jh4ZAEuNZLjnPuVdF0udHQwjHkgiCvt0vVrR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109736; c=relaxed/simple;
	bh=/bO0FcTq2KFsnz8oL+oxGnSFuSkzz/vWNPAgvJFQEAY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ix9f2CQ6VhKVpfveDtEuF76xEIeTn3tLmYFk4TCGdqQo27dHUJb7aJb08a73X3XnR3kfxZKZLSgdaM6Spg5SX1ICRvxErgE1/aM+N8PLptd7jON1470RubmjDyYFDexObZLcAZCPAPCrmnlf21tBhaZjJjz2r5KVUW87I8zbDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IwiW26N7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=/bO0FcTq2KFsnz8oL+oxGnSFuSkzz/vWNPAgvJFQEAY=; t=1709109733; x=1710319333; 
	b=IwiW26N7pO8QRdVP4HjipPrCH8hR/r9/HpSuDgt4D2mNL4jmmOW089muzJcSdYIoD07aSWzEtUB
	xQXF1h2r1BARKplUnvDa35CPCl9UhlsMtEtxail7E110bT5EB6yAm2qKbIW9Bn4DMenhA5YrRY7p8
	5WMPs0yMnpD2JdzJ/y81/kWLZEchY7q9/7/8sIvuN7PbyQJyMH0IrW2qUxNXUFbHd8e9JgbNbvTSn
	bxIYa72UGTd+ZwN+OqpFwhjW+tCwP7sLKZMlMQBEVnvafl3Uyurf3zaBR8MJoQpmbiIW0vmi/XDWH
	ZuDHLTwp83tZZJjvADF2D6qISMKxagb/cm0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFVy-0000000BzmR-1fcL
	for linux-wireless@vger.kernel.org;
	Wed, 28 Feb 2024 09:42:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] wifi: mac80211: fix HT/VHT capability handling in assoc
Date: Wed, 28 Feb 2024 09:40:50 +0100
Message-ID: <20240228084207.18142-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to errors in the MLME rework, we didn't handle HT properly for the
bandwidth reductions, lost VHT beamforming capabilities, and included
bogus VHT capabilities on 2.4 GHz. Fix those things.

johannes


