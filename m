Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A9F51D644
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 13:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391180AbiEFLL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 07:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391178AbiEFLL5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 07:11:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0953252B08
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 04:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB2ADB8351C
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 11:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538CBC385A8;
        Fri,  6 May 2022 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651835292;
        bh=jNYZ30I4Kbyn658RSlIlc3RLATMbyV7DbFfECfjMuyQ=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=tBOg+5DNZg6zI4QMT8XGd35fFbbTWi7fXSvh06KJaVCMTZklz6MwO3q9OLODtYhJx
         WfKX2nUh2Gh//vKgSx7Br7Kyf5YtJRHi7O4Br6wWVwl1wJj7KG3e/TeLh9TqtuXrP9
         5SOuEPDIEc3D/k+yoP5BpLPbvsiRPXkpMepsMNmToPKWjKBMX2cUUNy0/iGTR9sWQ8
         OPcJgSQ3VcBVIsQzxi6iUY4kJ9B7zGefJlByDPXmYGMUuuUnBpOgOf/VvO5cwHUrUu
         Gc4vXBd65968x1bueq1xHf03zIwKmWpSvHKp4nnLLGsvQcmPWupfopOc5BNwha1pQf
         cDtvZkFHKP4Qg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ECA3C34D6CE; Fri,  6 May 2022 13:08:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mailmap: update Kalle Valo's email
In-Reply-To: <20220506084212.8952-1-kvalo@kernel.org>
References: <20220506084212.8952-1-kvalo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 06 May 2022 13:08:09 +0200
Message-ID: <87y1ze3ome.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> I switched to use my kernel.org address, the old kvalo@codeaurora.org add=
ress
> doesn't work anymore.
>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Thanks, that helps!

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
