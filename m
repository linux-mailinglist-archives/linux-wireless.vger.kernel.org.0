Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175E56640B1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 13:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjAJMl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 07:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjAJMlJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 07:41:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726F216483
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 04:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9MUKgd25aphukaT852AKd3FIc+ualJpdf/WpZbnVUmY=;
        t=1673354466; x=1674564066; b=sRwm0dYfuWPAQsZIOh4o4rBYqszfl8mMtKi0ZkjGnHr5GP6
        wGnz9EhbKhUlCn3zef6Bl8DQ0mj7Udf7oqGN/A0HDO/sAeqmcy5/yAgH5mEg5jiTIFDwUPFK7RVdT
        0sRpZ2ZSt9KnhtqoZDfeNjQ2YG82IHML2bwOwVuDRbv5gFeKbsjQIEBcbboKNu6JOeLcgwL2ZHRy4
        8xvcDypLCBUBKU0TdJ95TzYtfjqPX9V7piRFkP7vpEYr8t0jumhJ1ndCxJnyTfprWP7S3iD1DEtbJ
        Nw+6LecOsPAnqIUmSoNfanqe9zveNZQW2cmyHG5Vtv8VOlS8/mzyBhXEdCybQxfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFDw8-00FEEi-1N;
        Tue, 10 Jan 2023 13:41:04 +0100
Message-ID: <b73a8d2896c85c72f62450cd40cd6f075e7f7489.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Deduplicate certificate loading
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-wireless@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Tue, 10 Jan 2023 13:41:03 +0100
In-Reply-To: <e7280be84acda02634bc7cb52c97656182b9c700.1673197326.git.lukas@wunner.de>
References: <e7280be84acda02634bc7cb52c97656182b9c700.1673197326.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2023-01-08 at 18:08 +0100, Lukas Wunner wrote:
> load_keys_from_buffer() in net/wireless/reg.c duplicates
> x509_load_certificate_list() in crypto/asymmetric_keys/x509_loader.c
> for no apparent reason.
>=20

Well, unless I'm messing up the git blame/history search, it didn't
exist as a standalone function when the reg.c code was written :)

johannes
