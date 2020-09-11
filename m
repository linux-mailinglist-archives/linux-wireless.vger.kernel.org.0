Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13AF2665B3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIKRLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgIKRLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:11:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428DC061795
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 10:11:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kGmZe-002JnL-KF; Fri, 11 Sep 2020 19:10:58 +0200
Message-ID: <fd8fafe85f2d75a2563e5be766cce1f45424e2bf.camel@sipsolutions.net>
Subject: Re: Configuring WiFi6 in hostapd
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        Sugandh Huthanahally Mohan <sugandhgowda@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        luciano.coelho@intel.com
Cc:     Cedric Izoard <Cedric.Izoard@ceva-dsp.com>,
        "Hostap@lists.infradead.org" <Hostap@lists.infradead.org>
Date:   Fri, 11 Sep 2020 19:10:57 +0200
In-Reply-To: <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com> (sfid-20200911_184424_681805_505E3197)
References: <CAD_iCC8EyWV8bLdJ+VsRdMHOa6ccOOOOUMM6nMwDk16LtMppcg@mail.gmail.com>
         <PR2PR08MB464983615CFB2AF2B3BCD644D12E0@PR2PR08MB4649.eurprd08.prod.outlook.com>
         <CAD_iCC-=rvC6mC8pOKNKqrrWQv2wt9BXVMQB2DR1QKcGp_KbiQ@mail.gmail.com>
         <CABPxzYJ=vJB4pnCC__G6Luhdp_m51Z_nKq80HFxEfN6cdsKQbw@mail.gmail.com>
         <CAD_iCC-koZwPCew4+n4nk8Ou_jWC2BxxcSDy_rf9KnO4Q=MO=g@mail.gmail.com>
         <CABPxzY+tfkjKETjdKJE7AjY6ELFfsLw4utVWOfXwxuV4C+RK8w@mail.gmail.com>
         <CAD_iCC-=9XU-DbfUorUtSRzCOEW=gr83T8ZSMvJn_xFgoMWvew@mail.gmail.com>
         <CABPxzYJmL7x1Hfx9Yf+4XT6xngWNmYC9ZGGvDYqLo7y2bNtCow@mail.gmail.com>
         <CAD_iCC9Vu55FG5vHSWF=H8v-ZZKQoyin8B-1zBtaJ+2MeJqCjg@mail.gmail.com>
         <CABPxzYKVK3OK6nKMrLrBfdy-Yz1v_bbyhHHLCkxnFzWtFBSGaA@mail.gmail.com>
         <CAD_iCC8XDNXfDmghhXyK8auFg5WinqaACpbpbiZ4g0toaDoeiw@mail.gmail.com>
         <CABPxzYK-HN-Q3wREn+6qAkiHAnkuyqz-g6m9XpUtaMd8ckHQPg@mail.gmail.com>
         <CAD_iCC-LMnDeL-e-i2GPYe9fRruWxkKvHEsNGDERv2j8eN1YFw@mail.gmail.com>
         <CABPxzYJVwjPGrHitstWkgiL+kEB9AeTMy_e5nu7FNXVv4ZNk-A@mail.gmail.com>
         <CAD_iCC_1TV_wQK+xOWk48eaJhWo82CZgTL-g4jg7tOdVxvqEZw@mail.gmail.com>
         <CABPxzY+2OO6nptyE+oH+COLe3pVgKhji=H1trP7m_bcpVqEe7Q@mail.gmail.com>
         <CAD_iCC-x9J4UB5aVR85WNi4OwaXQiU28+4B1AD176zDu8DBhwQ@mail.gmail.com>
         <CABPxzY+oy=p4QLHfyVMprigHOpTJEJGsJ-Bsti5b9Ly=eDy+cQ@mail.gmail.com>
         <CAD_iCC-mCo58fs1v+bqyB=NRXkQDTa20R=NGe+SwTP2s7NPfOA@mail.gmail.com>
         <CABPxzYKckJ94+96YsTY4Y7D7_z-Pk=b+T1tvu5BzaoVjVi0apw@mail.gmail.com>
         <CAD_iCC8StVW7Yh9f8fm2Da7LcN6LQzR=ssp+1E8-=YYCM-5tOQ@mail.gmail.com>
         <CABPxzYKFUN-hyhJnxG_-EcD0L0bsp8rn+b+tyt_ReAf11vzKng@mail.gmail.com>
         (sfid-20200911_184424_681805_505E3197)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-11 at 20:37 +0530, Krishna Chaitanya wrote:

> > [  228.315290] iwlwifi 0000:03:00.0: 0x00002078 | ADVANCED_SYSASSERT
> > [  228.315294] iwlwifi 0000:03:00.0: 0x00A0A200 | trm_hw_status0
> > [  228.315297] iwlwifi 0000:03:00.0: 0x00000000 | trm_hw_status1
> > [  228.315300] iwlwifi 0000:03:00.0: 0x004F8E3C | branchlink2
> > [  228.315303] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink1
> > [  228.315307] iwlwifi 0000:03:00.0: 0x004E4FF4 | interruptlink2
> > [  228.315310] iwlwifi 0000:03:00.0: 0x07000101 | data1
> > [  228.315313] iwlwifi 0000:03:00.0: 0x48308403 | data2
> > [  228.315316] iwlwifi 0000:03:00.0: 0x00000005 | data3

This means that we got an invalid TX rate, notably an HE rate was
requested/configured on a MAC configuration that didn't have HE.

I think I saw some patches in this area (configuring the MAC to be HE)
fly by internally recently, but not sure... Luca probably knows.

johannes

