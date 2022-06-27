Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF94D55CBC3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiF0PEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 11:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiF0PEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 11:04:07 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78A1707D
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 08:04:07 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1656342245; bh=JnShx9ff+v/hZ//UO2vtlobKE4RR79JV1bBbsW0LTzY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tDWHVre/Y/Dc4gOHHBQPCoSPam7mHsTqIgd1+nGML+o4Es7DlMRS7jv2qdbPzmoHy
         KMqLQxj7+3+B9har4FhsK5IQqL9fIGGq7GPzedjhBEpIYWg4/inS2qcl6JmPDsB+OS
         jtNMq07XCSG0YhXLAtp8pjghI8sYyeeOv1aKZuErrUhpBQZGCvIhWnubkb5Lzo7H8o
         4mDIAd8g68RKZesiwVrDP0SB7BMN3ZRgifwYRLB5zbEWCOqaOyQ6QM0E/1OnqTR5VT
         sv0/M+eJm8KqmnXxC5GNscBE9VJ2PweBEbThjwel2OpoPdodGkWH7M+6tXa5N/eMhK
         G9b7O/CB2PMQA==
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5/7] mac80211: add a per-PHY AQL limit to improve fairness
In-Reply-To: <20220625212411.36675-5-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
 <20220625212411.36675-5-nbd@nbd.name>
Date:   Mon, 27 Jun 2022 17:04:05 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87czeub122.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> In order to maintain fairness, the amount of queueing needs to be limited
> beyond the simple per-station AQL budget, otherwise the driver can simply
> repeatedly do scheduling rounds until all queues that have not used their
> AQL budget become eligble.
>
> To be conservative, use the high AQL limit for the first txq and add half
> of the low AQL for each subsequent queue.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
