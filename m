Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4986014611E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2020 05:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAWEIe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jan 2020 23:08:34 -0500
Received: from forward104p.mail.yandex.net ([77.88.28.107]:46660 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgAWEId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jan 2020 23:08:33 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2020 23:08:33 EST
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id 9300E4B00AC8;
        Thu, 23 Jan 2020 07:02:15 +0300 (MSK)
Received: from mxback6q.mail.yandex.net (mxback6q.mail.yandex.net [IPv6:2a02:6b8:c0e:42:0:640:9de5:975f])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 8EDB661E0020;
        Thu, 23 Jan 2020 07:02:15 +0300 (MSK)
Received: from vla1-bdd5685c3f79.qloud-c.yandex.net (vla1-bdd5685c3f79.qloud-c.yandex.net [2a02:6b8:c0d:4201:0:640:bdd5:685c])
        by mxback6q.mail.yandex.net (mxback/Yandex) with ESMTP id BBOVZMhRWH-2FCGlq4I;
        Thu, 23 Jan 2020 07:02:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1579752135;
        bh=wltdw+Y4FZfJ9AEZIulqrneDatNp8MsguFUdlmxFers=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-ID;
        b=UA8h69O2dtycNGBniGLuAFAdtO2KDI3BCDwsoD+NKV10y1dk4ia2dLTvZVikTOwgv
         5G6JyNkor8Q8Uv7HCJtJowNOs2MQUrOXVJVmwH1jPzrJA6z5oOHquzsIND4/xriy6N
         EJtYujmbAKeoaaGFyXlQV8yiCJtgBa1RSbqhhvrA=
Authentication-Results: mxback6q.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by vla1-bdd5685c3f79.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id OCBBbOW1gm-2BxGIxe2;
        Thu, 23 Jan 2020 07:02:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-stable@vger.kernel.org, Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Stable Backport Request: iwlwifi: mvm: fix non-ACPI function
Date:   Thu, 23 Jan 2020 12:02:02 +0800
Message-ID: <1742750.tdWV9SEqCh@flygoat-x1e>
In-Reply-To: <20191020085545.16407-11-luca@coelho.fi>
References: <20191020085545.16407-1-luca@coelho.fi> <20191020085545.16407-11-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8820=E6=97=A5=E6=98=9F=E6=9C=9F=E6=97=A5 CS=
T =E4=B8=8B=E5=8D=884:55:45=EF=BC=8CLuca Coelho =E5=86=99=E9=81=93:
Hi  Stable and wireless:

I believe that Upstream Commit:

7937fd3227055892e169f4b34d21157e57d919e2
iwlwifi: mvm: fix non-ACPI function

Should be backported to 5.4-stable as iwlwifi failed to initialize
8200AC card on Loongson systems without ACPI support.

Thanks.

=2D-
Jiaxun Yang




