Return-Path: <linux-wireless+bounces-26066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06784B17400
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEB83AEF35
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Jul 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2722EF4;
	Thu, 31 Jul 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYGHqPus"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD591805B
	for <linux-wireless@vger.kernel.org>; Thu, 31 Jul 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976175; cv=none; b=rHz/R9TE9oBp7J/nAqX4whCNVirdmL69p7Kkxjka4T5fKML8PZCrwUkJSj7EUeQtFfzn7WDckW7lTvdx+WQHXhGvWWLLd2xmwPz5tD22ryBANohhgqcgLEYUxK5JU2kZN3a/0mfw159FqkZ20KJNuws3c9mrDnUXRz3fwmUg8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976175; c=relaxed/simple;
	bh=/DbdOR03CG+fHJqy+ql3n316LM1XPqyNW+BPxIMwfGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enNhOda9nkML478mEZwXwqb8MeHUUID21injLPr8+hTxqxi7sE9HnNCflehATH/PJVN/Ii3Z7/xY2kKw55+OR4sz+ExBp55bOpt8zO0J2MwbIlEsxDGVNoPV5ZJymx8hAyHRDf7PPAuIGCaAbz7NM90kGHKugzdJvU9Nwss2Tco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYGHqPus; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753976172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DbdOR03CG+fHJqy+ql3n316LM1XPqyNW+BPxIMwfGU=;
	b=LYGHqPustgfAFA7BcBaYm0XAFQxNkluW/xjQgijKorTsWVEiTFmUmgeSvF85K6LuY04Na3
	1tVoIevz3h4irndX1uXHEkLyuarBb2Ed+076BG9XUYcXAX1HCwLUymUKJ3tM4f8FrZV7nT
	bQP0DdCRangAfPFCmr8ylV/6AgtUF+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-zpMfCzMeNIGuzgEL97ql5w-1; Thu,
 31 Jul 2025 11:36:06 -0400
X-MC-Unique: zpMfCzMeNIGuzgEL97ql5w-1
X-Mimecast-MFC-AGG-ID: zpMfCzMeNIGuzgEL97ql5w_1753976163
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E83411800877;
	Thu, 31 Jul 2025 15:36:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64CD03000199;
	Thu, 31 Jul 2025 15:35:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lorenzo@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: Re: [PATCH mt76 2/2] wifi: mt76: mt7996: Set proper link destination address in mt7996_tx()
Date: Thu, 31 Jul 2025 17:35:54 +0200
Message-ID: <20250731153554.379975-1-jtornosm@redhat.com>
In-Reply-To: <20250731-mt7996-mlo-devel-v1-2-7ff4094285d0@kernel.org>
References: <20250731-mt7996-mlo-devel-v1-2-7ff4094285d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Tested-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>


