Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE49D3764A5
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhEGLpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhEGLpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 07:45:18 -0400
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CAEC061574
        for <linux-wireless@vger.kernel.org>; Fri,  7 May 2021 04:44:18 -0700 (PDT)
Received: from postfix01.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout01.mail.de (Postfix) with ESMTP id 22CA51003F6;
        Fri,  7 May 2021 13:44:16 +0200 (CEST)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id 06F06A006A;
        Fri,  7 May 2021 13:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.co.uk;
        s=mailcouk201708; t=1620387856;
        bh=1gCss6vfCt9tMs4NbfVodO5Xn4oR063UFqnkt85Kibw=;
        h=From:To:Cc:Subject:Date:From;
        b=f5ASkVNVQYE+JqOzulJH9GUwGfnRqSz7sP/nme2dPdTgrfyhW9gu8BZTWU8GzeqVU
         /0pmls5N5tYMhb0GY+418dx79V5AgGDFEIRVFeydaDcRWjTlnnmIZbRAgc9CoARtHq
         +HfPX1HEogljhZlpq52b4V5nwMFdpFFfJvE25Bzw=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id C850BA03D0;
        Fri,  7 May 2021 13:44:15 +0200 (CEST)
From:   mj888@mail.co.uk
To:     seth.forshee@canonical.com
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Great Britian (GB) on 5GHz
X-Priority: 3
Date:   Fri, 07 May 2021 13:44:15 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
MIME-Version: 1.0
Message-Id: <20210507114415.C850BA03D0@smtp03.mail.de>
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 520
X-purgate-ID: 154282::1620387855-000063E7-401C19AB/0/0
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thank you Seth, =0AStill witing for reply from Ofcom but coincidentaly (=
or not) they have =0Aupdated IR2030 last Friday (30 Apr 2021) . It does=
 now contains =0Achanges I was refering to: =0ADFS IS NOT LONGER REQUIRE=
D ON 5.8GHZ =0A(BAND C - 5725-5850 MHZ) for unlicenced indoor use. Pleas=
e see =0Ahttps://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2=
030.pdf =0A-------------------------------------------------------------=
------------------------------------=0AFreeMail powered by mail.co.uk
