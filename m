Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D95AB4ED
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 17:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiIBPUz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 11:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiIBPU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 11:20:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7756714A910
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8/9p4XOs9ynADcwk2rJHB943ArYkje+5EGwke1msBxs=;
        t=1662130390; x=1663339990; b=WrhoMhLOb9ZkiXfYuLUo0LvJ1xj4pVQGy5oobv3sJWrch6E
        V+CuP6c5Ws/xpRDSytC8ORZNsO1FCmcN+VP1ivfZYv3a0IOAn/MNcJrz2x4lZLmAviOWKX48+aHyG
        uW+uZXLLVjflRhzms/MHSQo3W0pM0aHNRkae54V8OInhycWZlF9v7pdDjIFYX5vwfIwdY2nGbxzfG
        RgxEcOOPo4L7fgGE/9PmcDZxHN0amCjJkyOEypST7DS7uJshLmw3EgN6bbf/L7GP/LXJHsEPB/219
        6q5yMT8C6dIKRmjJSpwZo4TvBrYISDNPM/u1pwr5l0vN4LkVEqNaSBkcfHCEUb8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU82X-006DLe-0q;
        Fri, 02 Sep 2022 16:53:01 +0200
Message-ID: <b8674e67fee2393d4c5fe9d9842028545c6adcfa.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>, sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 02 Sep 2022 16:53:00 +0200
In-Reply-To: <20220901232734.5488-1-cesarb@cesarb.eti.br>
References: <20220901232734.5488-1-cesarb@cesarb.eti.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-09-01 at 20:27 -0300, Cesar Eduardo Barros wrote:
>=20
> +	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
> +	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
> +	# requirements, we can extend the range by 5 MHz to make the kernel
> +	# happy and be able to use channel 144.
> +	(5470 - 5730 @ 160), (27), DFS
> +	(5730 - 5850 @ 80), (30)
>=20

If you do the latter as 160 as well, and add AUTO-BW, couldn't you split
them at 5725 correctly? But I guess it doesn't matter anyway.

johannes
