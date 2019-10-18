Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69A4DC711
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439315AbfJROPW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:15:22 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58802 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404200AbfJROPW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:15:22 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iLT2A-0004eq-5f; Fri, 18 Oct 2019 16:15:14 +0200
Message-ID: <32a96b6ad48387876b7125adba147578564d297a.camel@sipsolutions.net>
Subject: Re: [Make-wifi-fast] [PATCH v2 4/4] mac80211: Use Airtime-based
 Queue Limits (AQL) on packet dequeue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>, Sebastian Moeller <moeller0@gmx.de>
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Date:   Fri, 18 Oct 2019 16:15:11 +0200
In-Reply-To: <CA+iem5v-K0pA9WLfDNxBKVjufgH=2MeuGmV0aDJysLT8jdawAQ@mail.gmail.com> (sfid-20191018_031141_683850_A491125A)
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk>
         <157115994190.2500430.14955682016008497593.stgit@toke.dk>
         <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com>
         <87o8yfg0zo.fsf@toke.dk> <751EA059-654B-4E06-A3D6-C727FE1FCE98@gmx.de>
         <87lftjfz51.fsf@toke.dk> <18FC6F1D-084C-44BD-87E7-C9F394D6FCD1@gmx.de>
         <CA+iem5v-K0pA9WLfDNxBKVjufgH=2MeuGmV0aDJysLT8jdawAQ@mail.gmail.com>
         (sfid-20191018_031141_683850_A491125A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-10-17 at 18:11 -0700, Kan Yan wrote:
> I don't think it is hard to take care of extra header size for frames
> with VLAN tags

VLAN tags are payload as far as wifi is concerned, so no need to take
that into account ...

johannes


