Return-Path: <linux-wireless+bounces-19987-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E9A5636E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 10:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430467A5C58
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA41F4164;
	Fri,  7 Mar 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s2NfunRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812A1C84CC
	for <linux-wireless@vger.kernel.org>; Fri,  7 Mar 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339074; cv=none; b=EfP0/JMe2zoX3DWdaYE//yG5f6YwxHf7D6B0qOaPLHDhkqw/2uAL7Su4yciIVKviRE3YqTZQ2MPwiDdc3auUpze+c4n5uqqqywO+HFr2U5FsXNn6Hc3Sa4ct8M5Q5u6PTWqXtf6I002JDtyrQki5YB/QBfmYAZZr/eMESWpNzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339074; c=relaxed/simple;
	bh=Lb6i8yAWqUZLaOlHSbbDpjEKDWMIJubn495TSEEIja0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSHAfb77yiyMkWJtP3yETQ9U98JManMtOK10S0fRThERh10haAOG+iH2/IeatELab79QBOD79yTTcemLJg7QGe4Ktq6YbenD9yp+F4fpPf3dUxbKMJm5t3zvDczbYeXMMvc1MyoEXrna+6hhTerY0EIuJocSZSzdK92cB4dzsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s2NfunRR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Lb6i8yAWqUZLaOlHSbbDpjEKDWMIJubn495TSEEIja0=;
	t=1741339073; x=1742548673; b=s2NfunRRID6NNoizTgnnfkpGioCzoNqO9zZMSNN1TvA8Tyx
	R0dricmOLe7bMnWStNSxa/NL1qICNHns5nUMV4lNZtgRiwJZG5dd/iumfwvyFdqJJFGrktBr5P1Vg
	sWUwkzs5GSDwLowuFJ1CDYGeHNLyPD2pFSh3npN1Q221Rmrd5bzN/w9cvBku4S6cT0nps2gN4gVqA
	ORX1jpx86nyyGlNCbpWCHIbb6BC5Z/y01+EO5Bg1/2vdD5wYsq3fO1EnBigntL98/Ow1KgwT9X+1H
	QJQUMRqpKJfqrIc4RaMjk5a3ZO94kbkvT5zJkLMpwpDt5KszD1IqtjjrBm8r/bHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tqTq1-00000003nXE-1TMl;
	Fri, 07 Mar 2025 10:17:49 +0100
Message-ID: <39059b0c01f42028bd17b54cc74f7d0aeaadf9b6.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 01/15] wifi: iwlwifi: bump FW API to 97
 for BZ/SC/DC devices
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 07 Mar 2025 10:17:48 +0100
In-Reply-To: <20250307000213.1678abe8c9b6.Iee3bbd245e7bc750b92624f7085afef02e7dbdc6@changeid>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
	 <20250307000213.1678abe8c9b6.Iee3bbd245e7bc750b92624f7085afef02e7dbdc6@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Why does the subject say "DC"?

And why should there be two patches bumping it in the same set, rather
than just one? :)

johannes

