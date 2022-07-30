Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39898585A22
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jul 2022 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiG3Kgh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jul 2022 06:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiG3Kgg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jul 2022 06:36:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8EABC15
        for <linux-wireless@vger.kernel.org>; Sat, 30 Jul 2022 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TwYcnGLSJ9FtzZT3COMxCNG/8jqI1JbJQjj2+IZlzIo=;
        t=1659177395; x=1660386995; b=JUHxH8sLLD0PcrOAXvbKwE8GX5hpi0+6aYIqX6f6Ywqe+zu
        04/FmPOHfxGthZtT3TQc96W5D0O6a2TE3rIADFSdFDnZO9or1KFSmxksy3TF295WmnUKzUqTZTPKj
        dIhqaIuvXfgsX+9L1hmRRk9kgWupGhASTSulGi8kYP03hNAYDAfBv0q9dqo7TqZ9VGMfEZ3PLjeli
        5uWyMF6XWdD8OC5E0BJ6FIo5iCmiQwzBO7kHA5YtK8EeyjrQ/vVYMUnqy9oIVwiab8bXSEKv39v+3
        En7K9ZXNCGbbdxWYAiO0NI8wYVl+1IIpcYLG+vAx1SRb/SYFVobqqIlOn02yBOsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oHjpf-00CF6B-2m;
        Sat, 30 Jul 2022 12:36:32 +0200
Date:   Sat, 30 Jul 2022 12:36:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
CC:     linux-wireless@vger.kernel.org
Subject: Re: [RFC] cfg80211: Add link_id to various key operations for MLO
In-Reply-To: <7b0d857f-90f4-6ee6-2186-01cadeda998d@quicinc.com>
References: <1657518327-17390-1-git-send-email-quic_vjakkam@quicinc.com> <2d90dfefd79fb2d4c942026856ef11ae6b4279cb.camel@sipsolutions.net> <7b0d857f-90f4-6ee6-2186-01cadeda998d@quicinc.com>
Message-ID: <7E6625AA-B48B-4063-99BB-E16CEF5F795A@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 30 July 2022 07:47:40 CEST, Veerendranath Jakkam <quic_vjakkam@quicinc=
=2Ecom> wrote:
>
>On 7/14/2022 1:52 AM, Johannes Berg wrote:
>>=20
>>> + *	%NL80211_ATTR_MLO_LINK_ID, If %NL80211_ATTR_MLO_LINK_ID is not pre=
sent
>>> + *	the specified key index data should be deleted for all the links=
=2E
>> really? for all the links seems=2E=2E=2E complicated?
>
>
>Thought delete key operation can be optimized in some cases with single r=
equest to delete group keys

Honestly, you don't even need to delete keys explicitly, when stopping AP =
or disconnecting it'll be done automatically anyway=2E So if you want to op=
timise, particularly wrt=2E RCU delays, don't delete the keys at all=2E I t=
hink at some point years ago we wanted to add a flag to nl80211 but not sur=
e we did=2E But we can do that=2E=20

And in normal operation you never remove keys anyway, just overwrite them =
with new ones=2E=20

johannes=20
--=20
Sent from my phone=2E 
