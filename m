Return-Path: <linux-wireless+bounces-14420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E86679ACE56
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E889B257F7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D741A0B1A;
	Wed, 23 Oct 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S1N0b429"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6584037;
	Wed, 23 Oct 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696285; cv=none; b=t48+IMkNsXa0+RFgyTnzkCpEHAS4dfr/+h72gC3RVRsQOWGaupwA/ED/32qyU5N4cZu3SStuxztmJ/9OzM3tH2rLtczOdzUCT0Yw4dQCeDqfcphnSOqovgJiotJMGGTVcW9WYug8ZW8GoHrhLnRCAox8NAerCUozNFfswt1Idgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696285; c=relaxed/simple;
	bh=4UvAKZFX275NQidGPcFB/pYDjZWJV4DXPqKz95rRsFY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgjL1wFg2E5wU6rsFcMOitd+qQH6yNRWhN6ojq1mBUlvIxCKAxhuEJOiFdWnEZ/7syxa6F0lUfrR6ac2+U2Cnw8Cz4vvhmUbUzpxaZ2yZGr9henMbo1kne7F2X04ipW86EEKon6587UC5w+F21VMllji1DQAru4vXXOtfR2JfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S1N0b429; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4UvAKZFX275NQidGPcFB/pYDjZWJV4DXPqKz95rRsFY=;
	t=1729696284; x=1730905884; b=S1N0b429p7hPYQN865/zhOWdLoIpMJcVwKzt3l4zP2H9Z/4
	XstnWyH/Q5tqkIneEiqPX0Svo0zn3zc9GMaI6jbosIQh363OL+bDRdl5Tn5Rw3kS+2CMdv4QSWef9
	XkuW2S5IoB5dz/A+yWBEatQ4Gkihyj28piC162Wp3yIEo3OhZmP3RGdhAq8/UhDno+DqPOhz62Nt8
	UuSSyliw3I5nckfCuje+eI1H19zbmiXtc6K78j7BP6FwtNNVon3h7FqBIxPVWtkWUNibzC+dYbgSo
	qLT4V5P2XmmQXmBfhLCRlWBRi9LpvtOCwcQc3Ksdsm4lbcxKa8AjENIIrOz3XIIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3d11-00000002jWW-256p;
	Wed, 23 Oct 2024 17:11:15 +0200
Message-ID: <289d08b367d1187d48e2ae6183fde4feeba45fc9.camel@sipsolutions.net>
Subject: Re: [PATCH] Fixed broken link to iw documentation page
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=C5=81ukasz?= Kimber <lukaszkimber@outlook.com>,
 corbet@lwn.net,  linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org
Date: Wed, 23 Oct 2024 17:11:14 +0200
In-Reply-To: <AM8P194MB1185EC77BD9AC01F139F9B67DC4C2@AM8P194MB1185.EURP194.PROD.OUTLOOK.COM>
References: 
	<AM8P194MB1185EC77BD9AC01F139F9B67DC4C2@AM8P194MB1185.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

This subject should probably have some prefix, and

On Wed, 2024-10-23 at 01:12 +0200, =C5=81ukasz Kimber wrote:
> Fixed broken links that I found while browsing Linux wireless regulatory=
=20
> documentation.

just like that should be written *imperative*, i.e. "Fix ..."


However, this was supposed to work ... I think the capitalization in the
docs tree is wrong, so probably better to fix it there anyway.

johannes

