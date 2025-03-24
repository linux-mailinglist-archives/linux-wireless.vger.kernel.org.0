Return-Path: <linux-wireless+bounces-20763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3015A6DEE9
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149C73AB857
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120D25C6FE;
	Mon, 24 Mar 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pe/i17oc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC42E3392;
	Mon, 24 Mar 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830789; cv=none; b=GMKzi7aeKU0cDgtV93eck5Blu51s6S7RdDzLBeeUmqDAjewTUA9lqkn2IuNhZCziA6gan5paWeICLNVZ6eWeZMwN9sn9zb1kK6DPJJR02ykCyPzoZvm0IROiFTRuGu5DauTEym7JPOC6LxMWmwy5Htrokx7rU0FzbpM3p26u6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830789; c=relaxed/simple;
	bh=GKllfRla6PLQUpUIHInuWX5KSkCONmLIEMGTW26gyEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSf8dJj9ZTcw5YeqCQSEjBMAZ5/vQFcjP4dTGPUofM+3jDqOxN/aNej0zPr14gYVMuOT4nuGNg7kKrT+OMcIJ1oD1sovC8zEQwM+ElyFFfx1dvcRWhTcyDKL9f0GhyWMs64Z/G19EnXlFg0rQ2//n/gqtgWPzHdba3VsLtZpaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pe/i17oc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NIHHjk88PfO6/OpNW3K9bwMJmgz3oUOSDsv8XDDX0wo=;
	t=1742830788; x=1744040388; b=pe/i17ocJL5TNSFKnjmf9QO4TJe/W3qNMvd7V8ZkWPTAaca
	X5DAircEcPYoWoK1aH6NSNm/aKcp+2HAmT7fSzOe6O9FqS21mQkPJFMmsPbqd2xJ0z8bnv1iJnh/p
	RGuW3ozTca6e6uLESUHw3GazmU1epfV7s+9pk2YGCvTpQ1gimXTdIdWQ8giwS2TbPl3FpiUuhjFcT
	jd5U54Gh5VJed+EE56nQDoC5hbxmZjP0U/g/YVCBdxBykhdc6HUnq825LMpMstuqQ0Co2NSYFr1QE
	s7AjEpRhbTeoOqyH0rpRVybP5M7lspBMtjnBRRDd4OBpr73ZgQkpNsXLE4uxqc1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1twjtw-000000045Z5-3tQI;
	Mon, 24 Mar 2025 16:39:45 +0100
Message-ID: <cca02b859f5732d6290eaef62b0d7389c740aa59.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in
 ieee80211_tx_h_select_key()
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?=
	 <toke@toke.dk>
Date: Mon, 24 Mar 2025 16:39:43 +0100
In-Reply-To: <Z-Fl9OUQ1EAEWW7h@pilgrim>
References: <cover.1741950009.git.repk@triplefau.lt>
	 <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
	 <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
	 <Z-Fl9OUQ1EAEWW7h@pilgrim>
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

On Mon, 2025-03-24 at 15:02 +0100, Remi Pommarel wrote:
>=20
> Finding a fix tag is not easy for this case because I am not sure which
> commit exactly introduced the issue. Is it the introduction of
> ieee80211_handle_wake_tx_queue() (i.e. c850e31f79f0) that allows packets
> queued on another dev to be processed or the one that introduced
> ieee80211_tx_dequeue() (i.e.  bb42f2d13ffc) ?
>=20
> I would have said the latter, what do you think ?

I would agree, despite saying "Move ..." that called
ieee80211_tx_h_select_key() twice, once in invoke_tx_handlers_early()
before queueing the frame, and again in ieee80211_tx_dequeue().

johannes

