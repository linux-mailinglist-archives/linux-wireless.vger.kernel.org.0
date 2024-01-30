Return-Path: <linux-wireless+bounces-2793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D91842166
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005901C228F3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE98C60DCB;
	Tue, 30 Jan 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CoAQR3PM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9625605B4
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610990; cv=none; b=Umb6BzZwiRAk/SJMHXmJudai1PPoBX5p3AOUfjxDwnMq1bWVuE+Ui/6MtgihY0DQpRGyXzwEizb5AxaWX6uNFMVD9wy717Am24mh/E9iWk+kgzdWZ6tpzWUw1bxWs3A7JGf2/qMpiV6PRF/JOVuYKx6BI+X0a/ZqRHk0tMZ04dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610990; c=relaxed/simple;
	bh=di8flAIpp6g5RQPtIYYFHbOug+3sjnYFWDW0lnLYJy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvLaeFldi42w53PwommqHmJ9KOy8ECk/lPyfjU1B/8pdFc7c/tk/859vDeFAW1ypcUwBJY/JlvUQqsvqow25qT7z8+ZeWksuY13qosa4sVw9xGUbLAFdIv38ulb51+ohGQ9xtolvzTccN+73sMECYXRVup0a/W1PK/9bu59ChFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CoAQR3PM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xikjPEi5orQMPMNjub+vz7NVquJX6hiu+CpvamtZ9Og=;
	t=1706610988; x=1707820588; b=CoAQR3PMvyPrA/QeP3hJGDcnPOZbU1ne6xIwThVLHqXv+Qt
	CrOMwjhU9KkMOLpLr8SvXFyZs5+ay6wrppEOClGvR+wbsX4JZ8JNfOpSVefuvBFKYHQa7/12ttd6j
	w3QAQqApbq/cjuyaDWaPb9wYV/cz/NQr/wfJqwCgotYgPa8jnVEqBOXr0svOphV7cE6+x4VXl7/I5
	lj2gwKlfFNpdCTiBtXvpQwvO3esqikvZOhxPjMHUX9NOWI/rNGYVzibcl8e5EZ8yrJqLl+/IcEvLJ
	wLPmHf7ro3wKG3pfEQUHdaU9Av6JoCf5ECvC+Csip8s7rc74TzSoGgQEK9cPR6MA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUlTd-00000005zNA-1pQZ;
	Tue, 30 Jan 2024 11:36:25 +0100
Message-ID: <7de5124fb9e8590f76a426d47e88ac6661c500c7.camel@sipsolutions.net>
Subject: Re: [PATCH v7 1/5] wifi: cfg80211: send link id in channel_switch
 ops
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 11:36:24 +0100
In-Reply-To: <c3ce6010-5cd2-4693-a43c-c89947cdb047@quicinc.com>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
	 <20240130043225.942202-2-quic_adisi@quicinc.com>
	 <184a2907d637cd924160681b40f1caffa2fa1e92.camel@sipsolutions.net>
	 <c3ce6010-5cd2-4693-a43c-c89947cdb047@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 16:05 +0530, Aditya Kumar Singh wrote:
> On 1/30/24 15:43, Johannes Berg wrote:
> > On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
> > >=20
> > > + * @link_id: defines the link on which channel switch is expected du=
ring
> > > + *	     MLO. 0 in case of non-MLO.
> >=20
> > please still use a tab (only) :)
> >=20
> Now I get your point. I was using tab as much as possible and then=20
> spaces to align it to ':'. You are suggesting to just use tabs alone righ=
t?

Ohh.. Yeah, we don't really try to align that.

johannes

