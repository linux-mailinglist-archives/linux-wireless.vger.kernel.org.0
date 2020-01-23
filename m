Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889921461AE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2020 06:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgAWFuO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jan 2020 00:50:14 -0500
Received: from forward105j.mail.yandex.net ([5.45.198.248]:56168 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgAWFuO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jan 2020 00:50:14 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jan 2020 00:50:13 EST
Received: from mxback30j.mail.yandex.net (mxback30j.mail.yandex.net [IPv6:2a02:6b8:0:1619::230])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id DE904B210DD;
        Thu, 23 Jan 2020 08:43:05 +0300 (MSK)
Received: from myt4-07bed427b9db.qloud-c.yandex.net (myt4-07bed427b9db.qloud-c.yandex.net [2a02:6b8:c00:887:0:640:7be:d427])
        by mxback30j.mail.yandex.net (mxback/Yandex) with ESMTP id GSoLttdzWg-h5QiPV0b;
        Thu, 23 Jan 2020 08:43:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1579758185;
        bh=a+piVwr8F8dxNKcGoe1UlOqWGQgy3NPCn57DfvQzan4=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-ID;
        b=bFqe3TPjK8aivdEowFnzG+G7eGRIyFIb4K4dyOIHV+9d1P1k8iTGlUfZWBdQ246rC
         oEQXONOKGa4iLohzBmk9h4raZ4WMOQSDR9+3oaqoF2ChrlaYgSU/8qDclNtjZ8mT6L
         VfA2pf9CHEqquAD4tscZL2uARMCfZaHRBbRZMq3I=
Authentication-Results: mxback30j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by myt4-07bed427b9db.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 87HHI5Vb6e-gxU8WMUC;
        Thu, 23 Jan 2020 08:43:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     "stable@kernel.org" <stable@kernel.org>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Stable Backport Request: iwlwifi: mvm: fix non-ACPI function
Date:   Thu, 23 Jan 2020 13:42:50 +0800
Message-ID: <5328885.DvuYhMxLoT@flygoat-x1e>
In-Reply-To: <20191020085545.16407-11-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi> <20191020085545.16407-11-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi  Stable and wireless:

I believe that Upstream Commit:

7937fd3227055892e169f4b34d21157e57d919e2
iwlwifi: mvm: fix non-ACPI function

Should be backported to 5.4-stable as iwlwifi failed to initialize
8200AC card on Loongson systems without ACPI support.

Thanks.

--
Jiaxun Yang





