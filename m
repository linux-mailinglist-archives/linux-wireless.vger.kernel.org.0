Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBDEFADD
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 11:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbfKEKVK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 05:21:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbfKEKVK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 05:21:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7875E60EE8; Tue,  5 Nov 2019 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572949269;
        bh=m6+jnjSIiLrbDy09TxEayX2ir/VhhtuoYc9zNCHqEqk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=EyqtQDPGcQ7ynFEU1chRQzR3r9OqIfkU/Pb7lgTE02DATQYznZZNr0uZk8+8zvj8e
         cN4xh0wpuBNET0r6oEFx4qwfOAdMunaJka0WBlmkUz5rfQmfG3KoO2qxvrZMxxyvkt
         D9TBxYoYZUbRqYsVfdgcDmg9dZL6YfogVY1l2fmM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from MURUGANA (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: murugana@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AAB960EE8;
        Tue,  5 Nov 2019 10:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572949269;
        bh=m6+jnjSIiLrbDy09TxEayX2ir/VhhtuoYc9zNCHqEqk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=EyqtQDPGcQ7ynFEU1chRQzR3r9OqIfkU/Pb7lgTE02DATQYznZZNr0uZk8+8zvj8e
         cN4xh0wpuBNET0r6oEFx4qwfOAdMunaJka0WBlmkUz5rfQmfG3KoO2qxvrZMxxyvkt
         D9TBxYoYZUbRqYsVfdgcDmg9dZL6YfogVY1l2fmM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AAB960EE8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   "Sathishkumar Muruganandam" <murugana@codeaurora.org>
To:     "'Johannes Berg'" <johannes@sipsolutions.net>
Cc:     <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <murugana@codeaurora.org>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org> <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
In-Reply-To: <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
Subject: RE: [EXT] Re: [PATCH v2 0/2] add Wide Band Scan support
Date:   Tue, 5 Nov 2019 15:51:04 +0530
Message-ID: <00d301d593c2$bd37d8f0$37a78ad0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHVkwkVT6m+l26KbUeGwXX9pHkuA6d8Xe3w
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Neither of these are scan use cases (at least not that are covered by
> nl80211 scan APIs), so that doesn't make sense.
>=20

Actually we had extended the existing 'iw scan' command to do Wide Band =
Scan using nl80211 scan APIs.

dev <devname> scan freq <freq> [HT40+|HT40-|80MHz] [ap-force]

dev <devname> scan trigger freq <freq> [HT40+|HT40-|80MHz] [ap-force]

Raised patch for above change, [PATCH] iw: Add phymode parameters to =
scan command for Wide Band Scan support.

--
Sathishkumar

