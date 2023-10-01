Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36B7B472E
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Oct 2023 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjJALab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Oct 2023 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjJALaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Oct 2023 07:30:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C306C6
        for <linux-wireless@vger.kernel.org>; Sun,  1 Oct 2023 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=teMlNCBg2z/jLU8J9aqt0kOMEmH7AHLnUK4SshnKKDs=;
        t=1696159827; x=1697369427; b=iPVEGcmptun2znF92IiqXkVxAyqurNuQ/AHxhIedBYMx3vS
        ZyIMqzYmY3BcaRF9Z6YSdD/3zxt2n8PBbdyOmng2JnUXC9/snj6MskftKgLr7WsuI33F5olK3+JeH
        xUjU+g9CFs08ZPBP1keNdAOq+5tAISGhzM9Ior63qToY9xFO4W91vjHgflZxc+kGGnPLzmhj+dQjV
        iBmBfvzySbQLSrIeYFE8k2M6HXClEu2qZrw2/qmdf7sug64Z6ZXYY9G8IqqJSEZbaR5sEdXt/QS8x
        fp6J2MJ466zDGXJO9HYZQI1KZy6fQtzE7uOdokkqwFcGx1INNVrBZ7iCF2aNN/1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qmueW-00FRxo-2C;
        Sun, 01 Oct 2023 13:30:24 +0200
Message-ID: <015593654d48233f1faae18e7bacbdfd50c6a84d.camel@sipsolutions.net>
Subject: Re: mac80211 bugs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Dutton <james.dutton@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Sun, 01 Oct 2023 13:30:22 +0200
In-Reply-To: <CAAMvbhGsA4A9qHrYdXcNXLzv7a7xZZq98f90Q-Btb-9vs9ayCw@mail.gmail.com>
References: <CAAMvbhGsA4A9qHrYdXcNXLzv7a7xZZq98f90Q-Btb-9vs9ayCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2023-10-01 at 11:27 +0100, James Dutton wrote:
>=20
> Why is there no defensive/security-by-design programming in the Linux
> wifi drivers?
>=20

Since you clearly know better, I suggest you maintain your own wireless
stack :)

johannes
