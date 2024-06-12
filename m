Return-Path: <linux-wireless+bounces-8864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5365905279
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E9B2823CC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F516D322;
	Wed, 12 Jun 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FtYOC6gm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BC171656
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195448; cv=none; b=mS0ZqdEUOGwraTa4KiOG/N2o82Li5es3YTiwI/N1dgyKw46NIPQHwfTShR25RN0/1NOu+GjFRYPkW4q7+bqbeaWWXN6OUlLt6bnGr01wVnj7QVC78jNZp42wQOU2c1RJMTRMBPIFxY1mkDLQ3EtnVxhQQ5TNza//fKAgF4g6KV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195448; c=relaxed/simple;
	bh=8Qku4YFbzfp5pMN4Xw+OMbvZCHXimKPDLGZ1KY1/5YY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BjnEP3ehAR+QkdVnRgk/TOC2pDK9M+rl49vYJlzpdNpJ1pNNt9bdWLLFuunT65zVLTfMHNepC7dp7LmESAvneZlERfq9CkYht5rB9CZEhSEuRuF3bSDwWr7Jeq/FHkOyJBMJlkgJhgFSrtv42vz94xEgm0iXTbU+sWSHCHeTiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FtYOC6gm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8Qku4YFbzfp5pMN4Xw+OMbvZCHXimKPDLGZ1KY1/5YY=; t=1718195446; x=1719405046; 
	b=FtYOC6gmdKkyaj8n7eIg06E2868RrUcSAzBi16WnHAjgKFsfLkDkDzKgvn78tRrVsLNGJUMX5n9
	T8oBjyKQmpYkTxC5itW6R4tSNo84HMSuYZKlbIeS34k7kODXn5OkbVCAov19FAglujcHNqXgSOH0T
	yPFKaEqCur2y72wJGFqgvMHZr8oZ2RQ5V5ujwrrh7rrBrlSZVFroSvymP1ue/DE4p94SZR7ppO7tY
	gSjvnop0+3zSSguE3Uf342awcOerg1QtjmO+7oaz2/ofyV1ZrYHlmMJ2qRaDTISUzrFz8jOuwEYlx
	Ol15q5Ul2mGKXyXG7ffoyzg4ECd8pArCjo2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHN7k-0000000AGRh-25p5
	for linux-wireless@vger.kernel.org;
	Wed, 12 Jun 2024 14:30:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] wifi: mac80211: public action ECSA frame improvements
Date: Wed, 12 Jun 2024 14:28:34 +0200
Message-ID: <20240612123037.36687-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Public action ECSA frames are not protected, so treating them to
e.g. change channel or disconnect immediately can lead to issues.
Use them only for quiet indication, and then check against the
beacon - in case of beacon protection, that will give a good
indication.

Perhaps this code should only apply in case of beacon protection?

johannes


