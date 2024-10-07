Return-Path: <linux-wireless+bounces-13582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BC9929E7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CFA1C227A8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C441D14FA;
	Mon,  7 Oct 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IOxvDB6w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37018787D;
	Mon,  7 Oct 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299084; cv=none; b=qQ8w5eIDTwPaCwei920wFa8gOquqZ6UbjUJ2o9zo5UVlkUwrZo5GdBuNF1o68OQNbr5PFU5vGjo+TrTdidG1C+8z5QIY5zkdZSoTxY4We23xpsExZVISUOvY4uH3+swF6d8L2uaVotOr7hnlaDkjcorJdTBtjzebDWV2pI3NG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299084; c=relaxed/simple;
	bh=aCZaOC4PneYXHigwxNE/eInOza6T/9Gt9EDLu8dGg+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0+hEi9pIydkAtDrxBfszNKBJqOE5yZgFOGKB6+X34ASUtuOp5fblHfAm6rZlz1AIlYlgVaSCcMtKnanm/KQHufTTnhb6P0cdq1fVdY55F1EB7VwIWiXV30uU1VW8+bWJwG0O0c/NRUwWv5Tv9Ggr8DSI2kRlmNg/9t9R45Ze3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IOxvDB6w; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aCZaOC4PneYXHigwxNE/eInOza6T/9Gt9EDLu8dGg+8=;
	t=1728299083; x=1729508683; b=IOxvDB6wcdXojtP0KJSOeYYeMk0DDMjhttPJbQXQ4bTVGcC
	B9cwr0VSVsbWvaanjEpW/3uUYWXNSFKDWXdVWdZGzgL1SsOVboeN7HfDVt+1WVa0q4KFMndzd2o2X
	/yLXZT5RQxtw5UAOwrNC5CsHOJUi+1b7dwdJNVEIGNG27OLkEBNumb691nguEmALsMNqG2KvLBRDe
	qx83yDU5jbE96rapI/CJykobyBEkJicI+gVwqhrnt39yCqVoLzMqsgTsBn7NF3vEur8A+ehIG/Xse
	IfvUbihVTzgW0oRmMN1n9uH3eUllsvZjdD56xsFv/68YJk+1f1Uvm35ScV39wnLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxlXX-00000003Ioq-3oDn;
	Mon, 07 Oct 2024 13:04:36 +0200
Message-ID: <d402977d8681c86c4a0e09962d396964ccdcb4a8.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] cfg80211: Remove unused cfg80211_vendor_ functions
From: Johannes Berg <johannes@sipsolutions.net>
To: linux@treblig.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 07 Oct 2024 13:04:34 +0200
In-Reply-To: <20241006225303.121445-3-linux@treblig.org>
References: <20241006225303.121445-1-linux@treblig.org>
	 <20241006225303.121445-3-linux@treblig.org>
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

On Sun, 2024-10-06 at 23:53 +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> cfg80211_vendor_cmd_get_sender() and cfg80211_vendor_event_alloc_ucast()
> were added in 2019 by commit
> 55c1fdf0d6c5 ("cfg80211: allow sending vendor events unicast")
>=20
> but never used.
>=20

Yeah ... we have out-of-tree code using this for CSI matrix stuff
(sensing), but I guess we can keep this API out-of-tree just as well,
though it'll make it harder to integrate in ChromeOS.

johannes

