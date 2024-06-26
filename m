Return-Path: <linux-wireless+bounces-9601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A95C9180CA
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3089B2686B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5759D180A7B;
	Wed, 26 Jun 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Yc9QNCtr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB214AD1B
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404219; cv=none; b=HnSgptdbM9nia4cPoD5PXVXqBcTQik37+Or3xXhIo/Kk5xehQbnBEKBTfqkrnd+tWL7sr3o9pv/x13ADFi+u/C9Cu+R9eDGgiSPHuGZ+6myNtfL8AyYrWhXllHUrqF0xF3VB8yk4qYKmbf/xyfEBgWctMHMhCNv9CNXod4Eods8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404219; c=relaxed/simple;
	bh=axEml8jmseBUxscCJqzT2ustxB4jLe2/J9YQvuObzX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRWuHg26QOBGXbZW8dh47zr/mnYzVWNt/QI2I6QV9IK94T8de9FXLlN73vkGks6pxQ2rpbAVWbGBB0dn90l6Mv7rkUoAlVfy0MMPOAEDPpcLePG8g8Y+qW4nbGQXnbaYzfBEqhiVnjTH4U7GBoRhSW83SHl/BtJgJb/beSV3+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Yc9QNCtr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=axEml8jmseBUxscCJqzT2ustxB4jLe2/J9YQvuObzX4=;
	t=1719404217; x=1720613817; b=Yc9QNCtrLsXwg+iF1BmMrolTwKiZOFSZzXYixMH/xjiiMiM
	Us2RlH2xCp3fpzeAED15tdOIEUrSC6KDBVHzzX7gR5cawqBoKDuvroqEt9JCsyuhx0DoQnoDOUdLM
	wMTKGru2NlW94cieQ4VT1BC7WOrcnWoKOF9K/I4mRNnSfHeKIkQOukV32hqSye5X6OF7buWe4gVHN
	BG2Ur+z57i1I4kmY8dV3WMLrFnSPs8JesiSXZrw+uIDiOsJLz5mgZ8CkU29gVGSyR4GLvxg32f/R6
	Lv+n7BxS4Dgmpl9t+ZmiAsMHrn5QqISb2RG7au25o8AVGZv/uD9dHxLaXEgKrSdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMRa1-00000003a5M-3rSr;
	Wed, 26 Jun 2024 14:16:54 +0200
Message-ID: <6b70365be2858b557340d3799fd7965f66bae2ba.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/9] Revert "wifi: mac80211: move radar detect work
 to sdata"
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 26 Jun 2024 14:16:53 +0200
In-Reply-To: <20240626045216.3754013-2-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
> This reverts commit ce9e660ef32e87441bf59b04f67a24113e82546a.

Should have 12-digit sha1 and title like in a Fixes tag.

johannes



