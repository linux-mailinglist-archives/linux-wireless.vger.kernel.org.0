Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC887747BF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 21:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjHHTSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 15:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbjHHTSW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 15:18:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FAFF626
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6GDFlftfhP/GMR1eNcMBvMmcjXk4zg1377enK488Yns=;
        t=1691512870; x=1692722470; b=h9VtglFblRlDtrldVn1GbwmG3kTSEsM83xiR0tcCC0dbWtQ
        nIGeVU3P0SbUT1C4oh5ylHX664xgWko5jYOA9Hkz8RikTdkpoDLlPGnrtYF83JW+y2er0ng3XNDFa
        tRIZrV0r+5VBdJgJwrXsQHEGwAy56b6dCXqeFgs4orlNPIUGOXzSgSGgb5cPJS1emnef2TrXxnT0C
        s6aOYltOnmGXF5AcI4Jqh1oqcl4t7PH/S1zOZ0jHYo3hHU1PyXBxXs6XgbzBZSta2ndwi46/f5mrl
        DZ89iiIo3b7fNj0uJe1DKR709oOFDTkWNbSGakoXxaGkhiLdu3VNcVqGoVz3twCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTI34-00CQx7-0j;
        Tue, 08 Aug 2023 10:26:38 +0200
Message-ID: <d24e41fda1a9a9742be265cd5445b4a4cb864142.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/1] wifi: changes for FILS Authentication for
 External Auth
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kavitha Velayutham <k.velayutham@samsung.com>,
        mohit.ghuley@samsung.com, linux-wireless@vger.kernel.org
Date:   Tue, 08 Aug 2023 10:26:36 +0200
In-Reply-To: <20230728151751.1637555-1-k.velayutham@samsung.com>
References: <CGME20230728071724epcas5p32f46dd6dd091c61aaba26f28897f6378@epcas5p3.samsung.com>
         <20230728151751.1637555-1-k.velayutham@samsung.com>
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

Hi,

So since there's just about _everything_ wrong with this patch I'm not
even going to bother reviewing it.

Please run it by someone internal to your company who actually has
upstream development experience. Until then, please don't resubmit it
either.

johannes
