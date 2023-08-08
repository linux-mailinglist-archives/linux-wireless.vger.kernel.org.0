Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E697B7747A2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjHHTRd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjHHTQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 15:16:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31081558C
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HOQqmtjUTJcPk9ODed9QIifisQolbwqSpXLq5B1tyYo=;
        t=1691512811; x=1692722411; b=F2ib9xng4G4bs4ZXgRLN3F1YCXYvDMyjd4R2ID7VRQnUGWM
        s6liZ1iE3veShVYzUHWmRFpgBwxsGbxCup/e0H3/N/yCTubyS1/7ig5qGIUx4aqw5JhPAz/p/5MC9
        dJmQ8LnBgYzHcPa+s9AcP63nzECTQu2ZF5nx7tpZ8wzx6ZEIKfcZOgBSW9G/p6dLTeMI621AbwAFW
        KNzSgtokDSzCyfBP5bb0/RL0dIrmty4Gbq1Yd4n32F2gE4wvn61ZAr+ieN4QYM2S9b+MSFOEVsnzE
        SPWjLDmu4fqeHSlWiEk1t7cFweTV4Lmc/NZOuWFkxXeXBswEFDd5aUm8+lr6uQoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTKez-00CasF-2Y;
        Tue, 08 Aug 2023 13:13:58 +0200
Message-ID: <2307e1741e9d32e8f1ffc4e83c73b63a4e32512b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: Add support for sending BSSMaxIdle in association
 request
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chaitanya Tata <chaitanya.mgit@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 08 Aug 2023 13:13:56 +0200
In-Reply-To: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
References: <20230719194039.16179-1-Chaitanya.Tata@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-07-20 at 01:10 +0530, Chaitanya Tata wrote:
> When WNM is enabled, a station can send its preferred BSS maximum idle
> period in the association request, add a new netlink attribute to get
> this value from the supplicant and add BSS maximum idle IE in the
> association request.
>=20

I don't see anything here that even requires all this code, rather than
wpa_s just including the element itself in the association request extra
IEs?

johannes
