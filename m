Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48602F789C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 13:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbhAOMUE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 07:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbhAOMUE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 07:20:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF674C0613C1
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jan 2021 04:19:23 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l0O4Y-006diy-5y
        for linux-wireless@vger.kernel.org; Fri, 15 Jan 2021 13:19:22 +0100
Message-ID: <4e1c65d44315255740950476b7eb153f0d572ae2.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: avoid holding the RTNL when calling the driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:19:21 +0100
In-Reply-To: <20210114235918.604bd54a533e.Iacd5916c0e01f71342159f6d419e56dc4c3f07a2@changeid> (sfid-20210115_000227_355936_3DB062EB)
References: <20210114235918.604bd54a533e.Iacd5916c0e01f71342159f6d419e56dc4c3f07a2@changeid>
         (sfid-20210115_000227_355936_3DB062EB)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> Please test/check the drivers ... I cannot test all of them
> but have tried to convert them all properly.

So I evidently sent this too soon - tested things on our driver with
lockdep properly enabled and get a bunch of things thrown at me... but
this time I really want to do it, so :-)

johannes

