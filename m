Return-Path: <linux-wireless+bounces-63-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4CC7F8267
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 20:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A491F20FDA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985E34189;
	Fri, 24 Nov 2023 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JGu0UZN1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24B1BF9
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 11:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=box+Rdi7p33Kw3F/j/VW9bY5Qimjk0tjDqvbl1YmbDQ=;
	t=1700852586; x=1702062186; b=JGu0UZN1LZXknlq0j7M7HTG5W5gJO/2f+JmQ7blZvBHnguX
	PkArrLqRXqxm180Y1GVd5dlFnvk1iQ5ZYt2WVzxtERxQ7WYnaYmTTdrS9N9/GKRU+4iKunQ3cs1rQ
	EpZKLFq/49ZusETT3/SDapQlExLB+4Hz2CfZ/ur7Drir0BOzWBVMAzWs4E6VlZs+vzv8k71t88+f4
	nsg2WApVEN6okpyAHhiJH9DqK75B9w/dbNOrXl17tGzTtuzbT+H4tp3OaKOami1rWfiIYUy596nsR
	moD44WCstL6uiwgKOGYcWtg1jDSGEvCmg5lTSvMX2VsueQUBDjLEx9LAjwSexbeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6bSB-00000002jQ5-3XL3;
	Fri, 24 Nov 2023 20:03:04 +0100
Message-ID: <1a2ada781ce53e8f1d9c85de44780ee895443c3f.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/1] wifi: nl80211: Add PTK/GTK rekey interval
 attributes for APs supporting PSK offload
From: Johannes Berg <johannes@sipsolutions.net>
To: Jithu Jance <jithu.jance@broadcom.com>
Cc: linux-wireless@vger.kernel.org, vinayak.yadawad@broadcom.com
Date: Fri, 24 Nov 2023 20:03:02 +0100
In-Reply-To: <20231113124742.13588-1-jithu.jance@broadcom.com>
References: <20231113124742.13588-1-jithu.jance@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-11-13 at 18:17 +0530, Jithu Jance wrote:
> This patch adds attributes to NL80211_CMD_START_AP that the user applicat=
ion
> can use to pass down PTK/GTK rekey interval times to the driver. If drive=
r can't
> support the configuration, it is expected to return failure to NL8011_CMD=
_START_AP.

That doesn't work, _all_ current drivers will obviously completely
ignore this setting. If you need that behaviour, you need to add new
feature flags for it.

> +		if (info->attrs[NL80211_ATTR_PTK_REKEY_INTERVAL])
> +			settings->ptk_rekey_interval =3D nla_get_u32(info->attrs[NL80211_ATTR=
_PTK_REKEY_INTERVAL]);
> +		else
> +			settings->gtk_rekey_interval =3D nla_get_u32(info->attrs[NL80211_ATTR=
_GTK_REKEY_INTERVAL]);
>=20

Why can you not set both at the same time?! That should be documented,
if it's really desired, but that seems really counter-intuitive?

johannes

