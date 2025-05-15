Return-Path: <linux-wireless+bounces-23007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC05AB8512
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB26A163BDB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C90222586;
	Thu, 15 May 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CNJ+K4dY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB4819
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309094; cv=none; b=IvoGp9OodK5q6cCetpYyQrUc7CrEoWtBw0gdPyaAv0MIbG2KPYXuEfcFqMKGYgsCSVMY1KfahHYxPMNHY7/md5ZNfp83FxunqGcUfRXsu1udDRa5iQ051AUliCtlV0rDU02YcBC5vchpn601BByqPntCvkGbszqd2j+gGZRI9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309094; c=relaxed/simple;
	bh=nbP+hUt5ezR0D0h/YrAgTQ2YrJRLyXqK7W822qSfr+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lV6R4N5YUzaONpvRydIBvGkij18KKYl9UGOZyVefmi3Y8fVL0S0GvlgoozPB/ZRDrNmTfyLiclACcmg/KNvUqUO7I7SaYW4tc5bmBVZcRsTzz1OGZXNYzeq7CVn8ZEKk72OjZ4eHOiEpy2sGzs2fuZmFPtJsp2KieSrVPbr72MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CNJ+K4dY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JY47adhL7cFE7+iO/2i/WLXzEU39C1S7w7JVNZx2vuc=;
	t=1747309093; x=1748518693; b=CNJ+K4dYdSlLcht797SddaB02+CXprh8OWLQWI41JWtNOFR
	0Ba4GhKegcc2XqqJxoEQi4IV/u/Ig43TOzk4la7XVW//OaY5UTvkayz4rceG0zr9MU5izg+w48Td0
	sJn2nwnIoE3QP/b4ymVTaJaB3Gpg6Onh8Mydnce1axxknIq3UN4QElXv4RzgWHdB8rPurIYPWoOr7
	0oeDzHzXYLpy4FLmTCosIsWNjP35a57dtQUPeQzY95edhJJE7fH1syD+wZHZF/uAp/ntNv8eNKC5z
	QjimlhxB+AZ+MJ3rTkF8gbQWg8ZsrzxwkcVBP7yHjLFONAVwyki7S7X26JNP+PkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWue-0000000B7vH-2YNY;
	Thu, 15 May 2025 13:38:08 +0200
Message-ID: <9e767a04ed838c3b4c2a491ec1ad69e3fc2728be.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 09/10] wifi: mac80211: add
 link_sta_statistics ops to fill link station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:38:08 +0200
In-Reply-To: <20250515054904.1214096-10-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-10-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>=20
> +	void (*link_sta_statistics)(struct ieee80211_hw *hw,
> +				    struct ieee80211_vif *vif,
> +				    struct ieee80211_sta *sta,
> +				    struct link_station_info *link_sinfo);

That should pass the link STA, not the STA, not just because I removed
the link_id from link_sinfo, but also that just generally makes way more
sense? Looking at this prototype you have no idea how to even do
anything link related.

johannes

