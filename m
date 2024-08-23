Return-Path: <linux-wireless+bounces-11837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C784E95CA4D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072E61C24707
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201F37144;
	Fri, 23 Aug 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ttaCVE34"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184B13AD33
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408243; cv=none; b=gQxfKM1NY9mr6Nh0bgcj99pGSb5EriB2CWYw/EB3ceDkrnracT/m2XQjb5CpZDGuFWL4RPyD8uKtADmo3l+boFx4aiT7WHsZZwy7so5b5NCsH/lqacxgxEMc+77NTmyzV/URxc3Afe/B0nPyMFQIqUOkozKUjuK/4/4KaNpQ0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408243; c=relaxed/simple;
	bh=tvCBbJ6kerQWekaeZ5S2rS0k5ywk1dooOWfZEQXtbEA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=boKTezmRTRcQLEbmfOq8e/ty8EyQN+8kEPKs9Ej/0QoVqhPgt976TD9iyHYUk1ZXeUjxoXdkDAVSARhG4GqEIuEjSRgyQz5ujh8Fu4Yna2TXttWs+OBLAHf89hCxgLOvqdkC4m3LXHMt1cbIwbeS4XOi1xSpDsBFLmn8zyex1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ttaCVE34; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tvCBbJ6kerQWekaeZ5S2rS0k5ywk1dooOWfZEQXtbEA=;
	t=1724408242; x=1725617842; b=ttaCVE34tgLE5yejGI+PNka7lxbLowRp7TANVSvLyOQqcSh
	jYwgDcE/Vx2CVGxCxcp/tb3S4PTF6w23L9rgkFs2WELIeSOUeVsSTTcDjkteEoxZPt45cKWxXQciY
	UpE/inGSv6XDZKlLj/FrjHHxtW+cbNPWwXO3OTIZNRRw4TW1mHsyJ1lzAsk4vW9OJUHjs9BvUWCCW
	0GQ+q+DjeqcdkpZpHox1AbVkxM0nvtYdO1MduE8tY1+gtWLJ3UXr330HeA89sv2BQwWPMqzT6Jhva
	1CnLPqDCIiN3Qi71FnTgbUmFjFdq6Nxob7nitavBOrLMlDcEJAy5KkbewI+3H6wA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shRM6-0000000FQUP-3dUR;
	Fri, 23 Aug 2024 12:17:19 +0200
Message-ID: <a2d18db2ad31e1dfe7780b39ad43c5db82e1eb93.camel@sipsolutions.net>
Subject: Re: [RFC 4/6] wifi: mac80211: support per-radio driver start/stop
 calls
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Fri, 23 Aug 2024 12:17:18 +0200
In-Reply-To: <85f5dcd7432c2b82dbf8de5df09d44935ebeecfe.1722885720.git-series.nbd@nbd.name>
References: 
	<cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
	 <85f5dcd7432c2b82dbf8de5df09d44935ebeecfe.1722885720.git-series.nbd@nbd.name>
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

On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> Radios are started/stopped based on the vif allowed radios. This allows
> drivers to keep unused radios inactive.

Similar argument here, I'd think you don't need this with
WANT_MONITOR_VIF. Is this really something we want? Why?

johannes


