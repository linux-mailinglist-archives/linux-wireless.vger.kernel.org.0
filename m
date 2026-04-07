Return-Path: <linux-wireless+bounces-34477-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJrUBHQg1Wnr0wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34477-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:19:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C583B0D06
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 481C03057C4A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276FF3603ED;
	Tue,  7 Apr 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRmp+NzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB535F5FD
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574890; cv=pass; b=IIdtLhmRHRDcrkRWGoI0BI5wwu1IVM0rtkgG1MvymJdM32Rsae6OOBxvbkwBtZvcpTzV/SjUb2VXFzxlOR09Nfh5W3zYOugfxUd3BPPVoLir3PYElqu+U37bpw99vUn1cfrSzo9OH65lx9VnP4SzxDmkouj3bEIhgvhMHaPWvZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574890; c=relaxed/simple;
	bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIymQdVCOef436tBe8VlM/HvXHw3nuclBYeI/q+KrCdcMybrUS7YHIBSimytNpo73UoSEGL0otz7s3KNSnNTQDL9enbFAkNR/ViS0ZxZpBA29hrOzDg4dh+6eLY2Y0vj4lPFj/E/5OBkexjxgZVzA72AzmVn1y6JLQ+NsZJU/j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRmp+NzE; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-60579b9c066so1685142137.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 08:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775574887; cv=none;
        d=google.com; s=arc-20240605;
        b=lqM/jcCaiBeeu1547lW5zielNx8ikvfvkacihQZ7OuQGFUTv5i18iH2a9zKfTIi1/w
         fy5CF1gxj0EwUwkjV+dDyazdJyhBPGLR+m1Oxd81VhwX0rOw+VB/1hJgR46ug5gNtMbr
         1rOIJZT7QJrrhBg5viWqKwUVE8nTGfdPQyVL9FgMaoQUSduyFK2woiPzz3iYg1WcU/Po
         /UsBZzeU4KeAqxE1cmq9kkqiP0QLdANpO22GbN8A8OzGtQPmhu0bH7tjR5tuFRgftqj9
         JIxzM+VerFkOnJFp3tCXPsv6BIsW7wgN2aKENDh4xGjcgbU27PmZLiWEedvTD3J3adQL
         1HRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        fh=Hynmm3D6fR1/K0xDCv+VSmRDjrlz+eg7kchkvAN09+o=;
        b=gpp60RIs18SJeUauL4iKTNNhNqRHy4vaQAMpK2Np1LQr6hwYEJdjI+ABP/k0U+nO2X
         OVeECZd6+QzWjY6yRBhKNHE2QgRCKYYRt0k0AOglQahi0a/DsPBa1QMcvA5JFE/4KSbv
         jpXCORZqdqI28fSYO6pmiMV98dm0UsnglIYyYYSrmDQsy8pDBtrMWtvm/2wsPa/6ngQo
         au2SRV7UrG3oDcJaQx5ahXY7dWpanKqVEWfAhuxn2ScMJYdLsbT345FexMDiv+0S+5WV
         1ux1xFsE6PmpPA0efNxo+CpZQDrmVzEqezYA/nEYbTuhqUKnMYCa7gV/PL3xHbR4IgDA
         dqSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775574887; x=1776179687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=bRmp+NzEmiSpEU3/+BkVW49B+fOD00XhLtwdmd5ailgWxEW5PGQ2rW08zarHXY0y+Y
         Zplec1TcjY1Rhy37CPctH0D5FGvPX1N8P6tXvFr8TdpxKegiKiynq3mEpgb8WdwRug3T
         UeyLAnn/I0N2gUfWQJQ7j6WAfIh6QJSLcQtwRmxgGDmuxd3rolh+yebjZuH95SIReZ6j
         +pOKWqLbESKoUWfVnxZf6ypLf+RyKMvD6iAPH4lJXkojDb3tk1gyZ9alVYsfbZZpJ0Lj
         7wZXHS8wDlCYzuJk3EcQD9tV/mAZuOLmGvrvII0XgQqnMmup5/cYSh8luM+6dIaK8smL
         34XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574887; x=1776179687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=KfyUIrcMkG1mNykQpWgvPEQW5wnerU4qUHOy5dEwUXdTQgwpO+srL+oGwsUnBQlVQI
         kEs5me0zmfUIDUMU17Yxk09K2KqVPmzDq7KeZC04a3g9rA/1gwLGSu0mpWkwnDk7Y2sc
         A5d97UNF0JEa9CdbCgjuOd9gRrWQwiucOxNxQkge9uImZySdd+zuwwiKSPJE8pcJ/32g
         lV+9tJyszILP3Ncrzh0iPcQUwC+1s4gL18J2DuArEAOqoAeOpg6RAmTkTLJlS+Zxs2hS
         Ry+h2wGNbh3plxWKE22IOT88Vhh3EbtJE9jqxSwrA7izHOwbh91sydgrYGAxPgTvJpN6
         oFpw==
X-Forwarded-Encrypted: i=1; AJvYcCX5POyWRHenFaW+fLDJhPkErDRl4XqAH7EnjPREQzkbG6X3LQO3pyPyAQhQzB3MNGutsTdGJ83OcYZocsM13w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjmTAJo7T80CuctLOp12cdPRa0pGnJNrvZ21PilfyXfHfNWW9
	jf69awnOrsXrOL7Ys+B5Nn4lPniHbeilFXagYdALMKyd3UUwc2/MAWnGFo4k4tju1N/Pae7ASkS
	IpbuW3/BU9uX11KIsZM3r0DNOgirFA5EDxERKQz6X
X-Gm-Gg: AeBDievSUFVOVIfuofzieem5xei/5mlo0vejWxJ9GImCq/GQ6b7e6H2xA4EdO6n73ft
	Y+JKKEqKuwH3ZxKb6/0CTM2zWotA1BYZCxWqKjXYNvWhspPT0XDIJrLi0IA7wGI6hYDYBvL8F7+
	HqTXNETZywrxxOd2jU543GVr6OzjKO/mKl5bz6PICIWAsdcpZuYnLMCJQqoOE01nRKk6X6HDscF
	xQdj82ZHxPLZDxIbK4/p36HOojP9o7w1t57t8ZzAdN9ekNuKczX5R2TiKY3pTUB3xxodDzj+blG
	8mteLeo0RZLyhfX02w==
X-Received: by 2002:a05:6102:8555:20b0:607:97a9:e3e9 with SMTP id
 ada2fe7eead31-60797a9e882mr169043137.23.1775574886413; Tue, 07 Apr 2026
 08:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407150758.5889-1-devnexen@gmail.com>
In-Reply-To: <20260407150758.5889-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 08:14:35 -0700
X-Gm-Features: AQROBzDVHNhmKDoXWfA937vlS7i5gl0nT_gzqkVTXTlHZU7d9eadHvamrDIvMqU
Message-ID: <CANn89iLweeu08XgFL345k1NVx56=u6RV_GqnfG2ArvLjUwktrA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34477-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86C583B0D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 8:08=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 (netdevsim) and __le64
> (ceph) fields where a direct assignment would trigger
> sparse endianness warnings.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

