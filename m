Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87F67E595A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 15:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjKHOlc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 09:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjKHOla (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 09:41:30 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF152691
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 06:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ixw8fBa4bXNaGiibsKo+A9yjOqD73Bbihcsn+62Mq9c=;
        t=1699453891; x=1700663491; b=BhvJey/hqYBi9gzWkYZbiESa1rGwCWbW1LPlMK2huxy7biK
        lhwdh1otnNVi731Eiwrnx9eXcjWhyi/Ak/SP4A1novvTCBX+i9wqM5fuiQkhF8nVB1RxrEJY4N2hF
        4ExbgSlhZnNHTa8CbOPHosEAH5Zu8yMIIbUp5y9mzQfBVSeqZY0IiwJVobXbNKLGhgrNEJ4aorUNB
        7qk7tSMuYpyzz0GObWW3c/0ETZxD9LNMsaQMQ8HG3w5ovSTtPtRfARKXySMkxyEjs1flAaQdEp8yJ
        mr0eVCcxUpuRiq5gTCk+jfdiDPONy8lqCtW6kcxI81Mj2IZebFVvlU6nvcBkydcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0jaZ-00000000YH1-3woz;
        Wed, 08 Nov 2023 15:31:28 +0100
Message-ID: <8e2b0ba0dcc7af2b7e4e6443816e8e3170faf4fc.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 08 Nov 2023 15:31:27 +0100
In-Reply-To: <009fc2c209027efb5578e57926276be81891faca.camel@sipsolutions.net>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-3-quic_alokad@quicinc.com>
         <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
         <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
         <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
         <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
         <460cb443-868c-ec05-7aec-5b1eee381ae2@quicinc.com>
         <28b099e7a37824f0b59ab824e67b3437485e45d5.camel@sipsolutions.net>
         <587c4a25-4977-b2d7-a587-f2a742105a43@quicinc.com>
         <009fc2c209027efb5578e57926276be81891faca.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-11-08 at 13:58 +0100, Johannes Berg wrote:
>=20
> > I'm okay if you want to move it back to chandef, in fact I myself can=
=20
> > send a series for it.
>=20
> I'm planning to start working on it now/soon.
>=20

Actually, I need to work on the wider bandwidth OFDMA thing first ...
which has similar implications. See 802.11be D4.0 - 36.3.2.7/.8 "80/160
MHz operating non-AP EHT STAs participating in wider bandwidth OFDMA".

Do you have any thoughts on that?

I'm thinking I should add it to the chanctx in mac80211, which will add
some implementation complexity=C2=A0there though but I think it makes more
sense, i.e. adding an "ap_def" to struct ieee80211_chanctx_conf.

johannes
