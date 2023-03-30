Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5BD6D004C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC3J4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjC3J42 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 05:56:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7CBAB
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=o0pR1ol5+kegCSlc51jrOSx12KAqAKoYuF906SQRxfw=;
        t=1680170187; x=1681379787; b=jCCCqSvRQCsOLwB8/iweIwGhCn1vIi3/qnNt+TnafVB6l12
        k/nA9+icFPW9IOnb4AaYWgXY9eK16vXdf3wvNoLiUV7Z38eHH0SX4ukToMf2iF3h6jb3QdX+uUiiZ
        bUlfPwjgUrqpfTQBg/ifmWcC5aeRXPsyKWISgwp+VG+6yYe9sfLkbCaPmT3iPGSN66qcbXhBiNk1a
        LHhgufmic1ekmEXSdOlnFnZackj9uleD/wriEeTs1r8kgzYa8WyCA4tMuFMlaRTqS6DC6nCafT9ml
        VxO5sq4dC0sESvB3ocNSnW7n4dXLcu0unwwYzF8Csj7XxrIyb/RjNtFaMLjgtmNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1php17-000ydZ-0r;
        Thu, 30 Mar 2023 11:56:25 +0200
Message-ID: <e498423c44efb285788b8d000e984dd5a297a2d6.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/4] wifi: mac80211: S1G beacon/short beacon support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Thu, 30 Mar 2023 11:56:24 +0200
In-Reply-To: <20221116020700.3907453-2-gilad.itzkovitch@morsemicro.com>
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
         <20221116020700.3907453-2-gilad.itzkovitch@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-16 at 15:06 +1300, Gilad Itzkovitch wrote:
> From: Kieran Frewen <kieran.frewen@morsemicro.com>
>=20
> If configured, use the S1G short beacon format. The S1G short beacon
> format includes a limited set of information elements.

I think you can squash this with the fourth patch so you just have two
overall.

johannes


