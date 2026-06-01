Return-Path: <linux-wireless+bounces-37281-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNYKNirMHWrHeQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37281-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 20:15:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24A623D17
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5C173014273
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF243E2769;
	Mon,  1 Jun 2026 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrexQGp+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2923E275F
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337699; cv=pass; b=hCnSmEpnfGVVjWRgdo+KJXeJqdpN70UxZGQmkoV+TfHNO0I4i0kwDB5LPHVsel3djS3oGHPxcXiAM0oB2zkf0qSEvYhNqnCcfRC3DUKf1fjYaUBm8XtubVpZsko3sPBk0PJRSCTP1jYgIwTEYQXXigcjG85zwjFbKEmHZFfGATA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337699; c=relaxed/simple;
	bh=4HmRVF2hepmyhN/XxqYyryulGn5Er+uqaDbtJWfi0c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfw0A0zMqRgJNMUJ8E8EZEHO352907mW9FLSR4q6JpJvnp0l3hcFuTwn8kYikIPcVBbZQSV3q9cqRMhDluHqkVYMBlh+GYWITqMGZ9ip7M0ginWgFbbsgCjrE+799ZEc2T/DEoPpOTkJ3CvogqGK3VUwIGT+9wO12s6kZLwRLPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrexQGp+; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-becfa735b9aso209310266b.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 11:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780337696; cv=none;
        d=google.com; s=arc-20240605;
        b=CMKUezGJYBzcGm6GQj+vUgbKOuZBz8AMRPckNGAx5pqMoJO8DUwgFLzak16unbKLcF
         zJCfhXSjkNAO2lZ6UEVDsp8jN9optKIfsZN8WKaS/6io1HmkArJ0S8V3hPCTNLZZasT0
         ZXCL9HZj7q8pe4PUccurn579P826jEaRJ2Wtc6DDa5DuCI6Yru4zwGlNKUlZtnE/0H/o
         4QNewfE5jIvYfOjs+WWvpxkAB0dAlsbwOgvZ+byk0XRBCaOTj//U/+8tpSDmPglmIjna
         n4tEZNzMT2KwA49fAICAAYsExuevhv9HQGv69gns9D1gv02g/UK7m0LCTX8C28/pS6gW
         64NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4HmRVF2hepmyhN/XxqYyryulGn5Er+uqaDbtJWfi0c0=;
        fh=8gfoUYlXFtOB2nQpY2a4hUpC0S2Agln6dD+3EGkevTc=;
        b=CJaq2Gg4aC9jwh1SJWkkEwta4vpGabpl9zf9ZcrDsRJmlY6VdkvrV09tucW2l/umbC
         KtV7QrOCQA17E1kzrdyDyGQAHC2MchQW0Tdh+1KrdYxUcTK7u9GBctp/Pn6QVzbRvQ4q
         SZ2GFXIk3FXub7p018nZ6B3dfGa0yNepjA8N+EIsP7/P6TT2DisChSS4JVdMWPPrr3aR
         xTw/Ly9c7gOBVAnEBgHkUH8DwtISzWHnK18y647E7BJX6licbkDlmUaNUqqI2VVJN7/4
         iQRCw9fifwgRqp+t8NXH4e2c7flPjylhlZXk+uSPIwjP1zYcSoMUxFJlTGknY6RZixxn
         37HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780337696; x=1780942496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4HmRVF2hepmyhN/XxqYyryulGn5Er+uqaDbtJWfi0c0=;
        b=JrexQGp+rB2yp26DinOIopmctXPWF1l9HsHUtSocNndiA+sHUWHYIakWDkG47swP1q
         ZQIcLdhgQvtX0BYpAT2vciouHZcGj/rBTHAEzQFDpEnCcZP0DdfUQoJ7fxBLx2cDYB/K
         d9VU2hX5v49nKUU6zXvkcQYluLu/SmT541s3jIvaFBAkOsSIGarsKkPkDfKPzbwx5e4C
         fW0zYj0+IrSQrm/Y6Ob96Tp3wI4RAuEtQ/iFIBl5IbwY0qOTlm78XXfr/dDAFbhtJQhk
         hg+tJQWfNi3gw/8QtAVfmu+35r6P+uUlPk3dhZUKxigE+Ln3m78cQRP8oTYBMSi2d5Be
         xVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780337696; x=1780942496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HmRVF2hepmyhN/XxqYyryulGn5Er+uqaDbtJWfi0c0=;
        b=j8Dcfn6puLwXJcgb0NPkP06Tq5usgw5x2L9o9I6isCZfkT41MtWnVqGsEEi83oYtU9
         q6s+DzNwUxYKTOwbD47INMTbi6Tj7OMuxhdU2vhvJoUE1JWSDqrR0j/AJ3xbWPYFPL9j
         6H/8mi6qk5kHpMqXzULWtqeoZFor+QRLj8P7DqGoepWVJ7phaf8KdazNSc5UaRSxTp9q
         EgwslqIm0nYEbCDeK/2LD9Ds6vqiFEquym7qZtZHej9QYhc0eYm+OolZ+PYButtwtGyD
         0XwPI3Syh/pv3Lthcsv08oeVTWjy1gyEw69B7u8zGmcxUZdpq0FoFQ2/+YkeVreYx6UG
         g9lg==
X-Forwarded-Encrypted: i=1; AFNElJ+a2u0COoAAWjvd4lWmsRaw9sYiayyrd2dVSylD+RPRrPHl1D+V+9pSg6HtkDNyHtGgVcPBAVnxrNBU3I5EwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cdrnnh2refOq3WlLoZyH3CK8YMgN4VdJVLOlqjORUOb0CODK
	XSYPLPG7gDhF3CGcNAwWo6aLo9XBsvmNvRlZTkF0Ek7/zEkwtlfRNM5WyO+Z/4Gb0K2y+Nfs2aH
	cZxxlTHXbA9ZJiyGnu8oihyMuFWY5usw=
X-Gm-Gg: Acq92OH7l5VX4PhQJ0fn8I6UPZouNvbE/u20+iRZIpLz/3yoCNYvPLr6233HGLwmnDn
	b9VdICPB+ycEblHffzWq/JH9axmYHKVJckhskOCE9TIFy3nzaLMSSd6U22jbTBUQ5vmajbjOx7f
	JwpYFU+uRaCPqJd0YhMFRQUFDetDsfoo4+KKUFBsjCrgg2eYnMr6eIM5MyCECSMhsaAP8w1yAmD
	4LD0Qvl7KYlPTd9/ecaff5F6R8uLG2V1hwoKig8NK02l/7DkHDK7aFOPr2SZFKXnCt+No00N0oF
	Kiv/xBSc984xr4Mg8TuC1xd8OcFeOfyZzC0Z3SKbXtmisRmG5Q==
X-Received: by 2002:a17:907:3e89:b0:bd8:bb13:2227 with SMTP id
 a640c23a62f3a-beab394bd54mr640730366b.6.1780337696213; Mon, 01 Jun 2026
 11:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
 <ee0e584cb2ad1b536d327eb89342d1646fa96570.camel@mediatek.com>
 <ahwla_obwnwr2cZo@lore-desk> <44c54ed4da0d294c567b3b0ad750f082a6f1be9f.camel@mediatek.com>
 <ahwzwHDF7fT9t7hP@lore-desk> <7f02be7c4f919413718a0218b3792d4b0a222ca3.camel@mediatek.com>
 <ah0fGek5y8Nha0kd@lore-rh-laptop>
In-Reply-To: <ah0fGek5y8Nha0kd@lore-rh-laptop>
From: Roy Luo <roychl666@gmail.com>
Date: Mon, 1 Jun 2026 11:14:44 -0700
X-Gm-Features: AVHnY4K7Rnr9HBZMT68ZgTpm2sqn42gpnxKwQoXBahDuVV30ZAwkIs0p7iRX8VQ
Message-ID: <CAHoxoj+N3AtJgFD8vGP+uDpj6anKMgPBtZGejLDgAz0ZyisSHg@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
Cc: Ryder Lee <Ryder.Lee@mediatek.com>, 
	=?UTF-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>, 
	"nbd@nbd.name" <nbd@nbd.name>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>, 
	=?UTF-8?B?Q2h1aS1oYW8gQ2hpdSAo6YKx5Z6C5rWpKQ==?= <Chui-hao.Chiu@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>, 
	=?UTF-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37281-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mediatek.com,nbd.name,collabora.com,vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roychl666@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EA24A623D17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > I mean the link_id is only corresponds to one specific flags bit of
> > mac80211_tx_control_flags. But there are other bits that aren't
> > handled. Wouldn't u32 flags make it more cleaner?
>
> Yes, I got your point, but my concern is if we need to sync link_id between
> mt7996_tx_prepare_skb() and mt7996_mac_write_txwi(). If so, I guess it is
> much better to pass link_id explicitly to mt7996_mac_write_txwi() since it
> does not just depended on mac80211_tx_control_flags and I think we should
> not duplicate the logic in mt7996_mac_write_txwi(). Got my point?
> If in the future (not required now) we need to pass mac80211_tx_control_flags
> to mt7996_mac_write_txwi(), we will do it easily.
>
> Regards,
> Lorenzo
>
> >
> > Ryder
> >
> >

Lorenzo,

I got your point and IIUC the problem being addressed in this patch is that
the link id assignment has unnecessary duplicated logic across different
places. However, the commit tile "fix reading zeroed info->control.flags"
seems a bit misleading to me - this patch does not fully address the problem
where the info->control.flags is cleared by memset in tx path when its
value might still be referenced, the field is still zeroed after
mt76_tx_status_skb_add() and whoever reads it afterward would get
incorrect value. With this patch, we avoid using the incorrect value for
link id, but the root cause remains.

The issue that Ryder tries to address in
https://lore.kernel.org/all/5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com/
concerns the overlapping use of info->control and info->status in tx path,
and it remains valid even with this link id fix applied. We have to be
cautious when dealing with info->control in mt7996 tx path until the issue
is fully resolved.

Regards,
Roy

