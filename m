Return-Path: <linux-wireless+bounces-34916-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNZ9HNHJ4WnDyAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34916-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 07:49:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D607E4172E6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 07:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65F39306971C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 05:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C82744F;
	Fri, 17 Apr 2026 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggAGqP9P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041B22F01
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404940; cv=pass; b=tTXxzbSmBbeuDoySjcrMutGGMU5cT750lZnzzYduFilEs7q81vaUTSZMBAlonUS8AGx8CrImrDCvu91Q4au8Pi9ZMD8s44mRDgOxh1BKh17vzlQdKPN/OE90V2wpvBySQu2LQtMJeH8neLjbUsw8UWiU/9I0K0MP+vXTSqeadIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404940; c=relaxed/simple;
	bh=ZAYF+E1N1pfH16OucRJtydbc7LthAdYUFcY9l8Xe/3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdvLaqps/E5fItOSHTvKeGDTnTgwlLPWD2V7COipgvcCSoncG75Q7VSEsy++CCkafJm6tpMF6M2dAKR5qrpHq26r3GmrOAtIpY0qkhKfZ/RfWdvclZfTsydyRRtRTz7YzbjV+14ae1EY1b0cogzu2rvwlEwHB7/h92axeiHbd4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggAGqP9P; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797ab169454so4306157b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 22:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776404938; cv=none;
        d=google.com; s=arc-20240605;
        b=i2mze1O/QZp2Ul67qMLya/IE55D85O0iCwxoecSHCT6mxg3HBSMWv/2btC5EWabAsc
         zZdeAA7s6r4aj524s9renqDy0pMNr2Odtc9OaK/FKo61iVSTvZanNfCkc+bd8qT8w76J
         k8hy6gGZsjBc4kv7c7s0UWXDYPVYL+k7qG7tg/12N3NN1GSS5AD63NxSQ4sqwY8M9pkZ
         0iuOX0grOrR4lEssT/GL8Tps7ySGOscIBKiFESx2OgK4B2NC/bIZskQ6JYM3dQ4gUgKP
         G4DHH+fltj2c2dAYAu2gJ7BfbCSRVPVS7n+e1Nd6nwRQqJOrTfTQkFJWWd7QI42b7POw
         s6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZAYF+E1N1pfH16OucRJtydbc7LthAdYUFcY9l8Xe/3E=;
        fh=qdDfbe01YJ8j/2C1TruMRpU9HNzGcd5ZonUThHsrR18=;
        b=bGWmPyWMPgGqqt3YWpnIQOsFdW9fAEU+UlCjGKQ6bQffRtFOnCngGga7OeL1N+Bznx
         zSNJ1cGHFm4/CGCYYJAT/SFbs1vO1w7pKCqQSlrx6skjdeNgmgJJtvV3s8W6lT4YlCJE
         FZVKUOfo4DTmsXl5/4QBsb0RUFa2VOP7hzXLUqGl3PgYx8L09Q4hj8cJHF2W1zEDM9aC
         OlytxkaP3qublnbVYLHL/Uq4AjLTCYzLSb7LsTN+X8Y7pZP3aML2AThaskLVgSdvOoRU
         NV7o+aB4D3oNZcjJOJC8GH3vV94aUjv5bOGEfmyWFauUUdQpqcJEqbAcBCmQqoF94+4g
         XyZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776404938; x=1777009738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAYF+E1N1pfH16OucRJtydbc7LthAdYUFcY9l8Xe/3E=;
        b=ggAGqP9Peb4tFPWeJ4TxuOpq2RKa40z3HuN9BJ8hZhFXzWUx9sBYZrAJcZGSewrv+3
         L/WRMx7Vk57YZw16vT/mZtwfhybT3yl3nllCkpIcpdh0qs3FXE307Bc4b7dT0cw1wwjZ
         GF9vnZjedkziKeMQXkD6Q+TKAtn9eyL5yPSgqP+EgDUuPsJzw0qCqQ2R7kH5lGqKD5gu
         NZK5ETb+4qrUFwQLmGIIZyHp/g6Gyuk7L4K+HnYDl84qJj1QPlMu1+SNcuVbXnPClCIl
         psn9m7TwPnInOlGj7p41zvEEVKZsFM5XUPIpvpfOIFA7LJow596VBAeOcb285rFzvOCZ
         LuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776404938; x=1777009738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAYF+E1N1pfH16OucRJtydbc7LthAdYUFcY9l8Xe/3E=;
        b=ZZctuq8sDULTzmCWV/+6yZ86tc5wPZ9mrBzagoIL5cpPrBQ+sotBXsGy+aYSn6FKnE
         eSK8QsLvhhyoCyXeQPXPoH6vjHhyuPutmyLt+r5BPxcSW4ygYyLpinXSxAMlwzn2RJK5
         e1FGfMVa4ihk7CZjL+1k9+7y2WRqZUBoHTZLoNuSuFV2dNeBxKM6YnojJen30phqiiJp
         XlqviWbtvwxFGf+eGx/Alb38Rrx/CZxdrAu02vCM0EGXxUefWhLvM9bwXGNBsN1DLL4F
         m8W5MeNNeh41PTe2ElhB94WB4HhiKhbwpr/bzmAgP7asmwebiB7wKjU1xItaVPXRrcfi
         sXyg==
X-Gm-Message-State: AOJu0YyJOHKEPT7wYJY7o8xa4mRGkTBHJjmVEhC46OVXSrXMUJxNiXHk
	6yL4HQ1OulHeWhoJ3fO/azsk1CufaFG/qoXCblmoFZiKvGW7bzo2sB/M1WuvkSB7zEVsB8yUTbN
	yv+y9THz9dXRepRvI+RBplkmPNeEEPWI=
X-Gm-Gg: AeBDieuufzzt8/ceZUy18SwWmr406jKUOaZauk+PMag4pgffJcHvs6kDBRo/xtCXqAv
	IMPF/+mdFjpDj4ehLSdHqmxVDMjeqkKlugffrAY32TbcftnTeVFG+n93eVoouuGZImnsQ1EG2xA
	DfJUyibcmbuUlYb1kagxUXEWq4ZDhIaBDLtnz/9nt1p8ZkSk3AYsKkItmpsZPKgV+qwYnq0+oS2
	pMOcyhGzXf6Q/2arBkgZpCVMXdsWtWNaHHAm367fGN6Zw44rTRCtHSIa+FvSYjLTrv9RUD8kluk
	Ra7zK+PW3MQv6xZrBFFwAkodHiQN28o/BnIBoAAzUNS6ldLyTUflGexh5vBx4oY5QIiZ9Vf0qrh
	qXzhKQZY=
X-Received: by 2002:a05:690e:1285:b0:650:5f31:2334 with SMTP id
 956f58d0204a3-65318a9082emr125673d50.32.1776404938537; Thu, 16 Apr 2026
 22:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414194757.163339-1-npetrakopoulos2003@gmail.com>
 <20260415052959.14844-1-npetrakopoulos2003@gmail.com> <ad69b2f3dbc74ea6b9b1a17f2a77fbb4@realtek.com>
 <CALdGYqSepO3xy9UerKXFfKLdj1BS1jGQh5YgkcSHrxYYY=n3Kg@mail.gmail.com> <CALdGYqSPY+bHQiQQq9z1F_F2NP8-tZMVy5A5qisnbg+5AmBeFA@mail.gmail.com>
In-Reply-To: <CALdGYqSPY+bHQiQQq9z1F_F2NP8-tZMVy5A5qisnbg+5AmBeFA@mail.gmail.com>
From: Panagiotis Petrakopoulos <npetrakopoulos2003@gmail.com>
Date: Fri, 17 Apr 2026 08:48:47 +0300
X-Gm-Features: AQROBzAsTLhRVJ5jFwC7e3Z6FjkShiTG3_tljyDBpMS2MIcaUIKJpgMMbTx6GqU
Message-ID: <CAAqNYjshEdO+Bv9ZEL_+rTReMy-HL7bqOD2Pcp8xGB45_RKywg@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()
To: LB F <goainwo@gmail.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-34916-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[npetrakopoulos2003@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D607E4172E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm very glad it works. Thank you for testing it Oleksandr!

