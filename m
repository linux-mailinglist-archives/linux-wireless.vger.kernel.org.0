Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232731F1249
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 06:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgFHEvA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 00:51:00 -0400
Received: from dal2relay96.mxroute.com ([64.40.26.96]:41661 "EHLO
        dal2relay96.mxroute.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHEu7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 00:50:59 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jun 2020 00:50:59 EDT
Received: from filter003.mxroute.com ([168.235.111.26] 168-235-111-26.cloud.ramnode.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by dal2relay96.mxroute.com (ZoneMTA) with ESMTPSA id 172923fc100000d8f1.001
 for <linux-wireless@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Mon, 08 Jun 2020 04:45:51 +0000
X-Zone-Loop: 958e1455007943b8dfa85f2dd26d8c1da45200657524
X-Originating-IP: [168.235.111.26]
Received: from eagle.mxlogin.com (unknown [23.92.74.70])
        by filter003.mxroute.com (Postfix) with ESMTPS id 1F9E96000B
        for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2020 04:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=libreelec.tv; s=default; h=To:Date:Message-Id:Subject:Mime-Version:
        Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KQD4UtAhRmIPDfF6lvBkHz2KLQsgHiHb05CyqGVDbI4=; b=izVxP+FYYVr+JpWMpcqz5NBM3b
        lf2Epfx+Bgn/EDj4IlQyTJJh3j5wb0Js/0hE6AYMq6YnGp9Rm1m+UgXSPtqZ2zIc4zq9QrjuU/438
        Tm1W2W1nrpl31FOKjzL7UmbPYUrxbGHJWAWW26CZzui21Bn8tCyenS9e0+jmFOKQNcS4BEsCdQX7q
        2mhjlhZe9DkPMSw9V+pocwWFih6mopMvJAFU9wlnYeCQluo/dp4eBNweglUAEnlV1Z1D0IbrQoWJH
        u75a6xKr31bVOPqy3Cdxw3kR/97h/GhwwwnwVoganRdCeSJFeDwT/FIeubaPkkew58EwTcOyssIXm
        BXHN5a5A==;
From:   Christian Hewitt <chewitt@libreelec.tv>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: mt76 support for MT7668 SDIO?
Message-Id: <3BFCA289-ADD8-4755-80C5-1889A9AFB41D@libreelec.tv>
Date:   Mon, 8 Jun 2020 08:45:46 +0400
To:     Linux Wireless <linux-wireless@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.14)
X-AuthUser: chewitt@libreelec.tv
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I=E2=80=99m a maintainer for a distro that runs Kodi mediacentre on many =
popular ARM SBCs and Android STBs (replacing Android).=20

Similar to my request on RTL8822CS, I have a number of requests for WiFi =
support on Amlogic SoC devices using MT7668 chips. The BT side of the =
module is supported in mainline for sometime, but there is no mention of =
WiFi.

Is there any plan or timeline for MT7668 SDIO support in mt76? .. I=E2=80=99=
m struggling to even find vendor drivers for this chip.

Christian

