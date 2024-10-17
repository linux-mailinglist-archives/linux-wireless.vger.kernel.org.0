Return-Path: <linux-wireless+bounces-14172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85CE9A2BCC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BED1B26996
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BD1E0B7A;
	Thu, 17 Oct 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bel5Oj8j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84B1E04BA
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188629; cv=none; b=kAB5AmibZo2Eu7Wvg9ibpnwORFWGif/ikoBcSLJ1+0MMAJJJ5Bn68oRHl298ACUgjcQ/kX9UL6JTTLOO94TXqn346tAHPm56s5f33X1jfA+DSGNCDl4QwkbMPnwIBYupGwiGvhKuQ/SJv06MqC3pkjgjkW8DWpksegn1jqSjw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188629; c=relaxed/simple;
	bh=mLSjiTOUh+E9CxgYwi1U1f5AhkZN84D58GBwPA5jKvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAjIRCVI0i2ASY9bvD4bXloat8p6PBhFPNUHQzeXay4j4pFqsuPDWRwB0kSzqoB2hYph3hXtSO4dDbFPm0L5NXAw7sPcJVd8bTi/7WzIJ94nJa+EinIkxKEAIPJDP1i+WI0M2MDtCe/m7DlM3qlAPNlZ6Q41h/9x2tKz36bN+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bel5Oj8j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729188626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mLSjiTOUh+E9CxgYwi1U1f5AhkZN84D58GBwPA5jKvA=;
	b=bel5Oj8jLzwQNdifH3eVExu7KzVdBb37E7aOhX552XYzyzgHa4M9lqkJ6EXlgGhaYxwAf8
	DuFiM8lR88BuljnnPp4h+cK9EGcX23KU2gJb6FqffsU65dvX8F/NvSD6JbHEccXEsT2Bwr
	2wgJxdIS3fMdUtWLAnVjBeKZtBJOBhY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-Ehjx0aHHPMOzPn1gosugIw-1; Thu,
 17 Oct 2024 14:10:21 -0400
X-MC-Unique: Ehjx0aHHPMOzPn1gosugIw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17D1019560A3;
	Thu, 17 Oct 2024 18:10:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.106])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D73E1956086;
	Thu, 17 Oct 2024 18:10:17 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com
Subject: [PATCH v4 0/2] wifi: ath12k: fix issues when unbinding
Date: Thu, 17 Oct 2024 20:07:30 +0200
Message-ID: <20241017181004.199589-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

wifi: ath12k: fix issues when unbinding

Currently, ath12k driver is not working from VMs but it cannot be unbinded
either from there. I would like to send these patches to fix the issues that
I have found in order to get the unbind operation working there, at least to
fix the errors found during the process when the initial error is detected.

Just FYI and out of the scope of these patches, I am unbinding and binding
to apply a workaround with an extra module to fix the MSI addressing by
means of kprobes to be able to work with this device from VMs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>


