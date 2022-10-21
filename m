Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EB60769C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJUL6E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 07:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJUL6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 07:58:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C22625DD
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jAh/PefSqRuPiAyF8LcEwVlhYdlbGTtiW7SxgEdftm0=;
        t=1666353481; x=1667563081; b=auk2V4CMCeOSx5Uv1SJLtUHgH9/TcP2ddrMq3PVnPN2p1/2
        CuICleG5XNFO/asvwZaj1MaBBx64Ppek4m7F0gCKGQVuYX9EBD//Hz4gp+KBNt/e75AxmR6KB/Bpz
        qVKXzcTNGQpic85TbTZwicvtHced8SJcGKv8zlZLB27icvSBwRdhEQGiVAaFHw8QW/MepQ2mmYFuJ
        iKfUmos2p6Z72JGrOvPmatgZzSkoTR5qZy9AkKdAN9ti1NpthdaqI5MbTgOxmEFBUjBmHc9C0nzyH
        LMixp6WlzHte3cmArouAMc8zQiI2WN1msuRN9QfWVMzF+pBDJjyB+jmHWC8Zmp7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olqf0-00Cqhr-2g;
        Fri, 21 Oct 2022 13:57:58 +0200
Message-ID: <878a0455b6af009b6e751152c714e5f310dba729.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] wifi: cfg80211/mac80211: capability advertisement
 infra for multi-hw abstraction under one wiphy
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 21 Oct 2022 13:57:57 +0200
In-Reply-To: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

Sorry for the delay!

> - Should we make the capability advertisement changes to mac80211_hwsim?

I don't think we can, unless we teach hwsim and even mac80211 about
this? IMHO doesn't make much sense.

> - Should we enable some of concurrent operations like allow scan on each =
physical
>   hardware concurrently?

Isn't that up to the driver? If userspace requests scanning all bands in
a single scan request you can parallelize it using multiple HW
resources?

johannes
