Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6124023
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 20:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfETSRs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 14:17:48 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:48703 "EHLO
        9.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfETSRr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 14:17:47 -0400
Received: from player718.ha.ovh.net (unknown [10.109.146.240])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id BCCF2131D6F
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2019 15:31:34 +0200 (CEST)
Received: from RCM-web1.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player718.ha.ovh.net (Postfix) with ESMTPSA id DD46C5E1B195;
        Mon, 20 May 2019 13:31:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 May 2019 15:31:21 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, kvalo@codeaurora.org, davem@davemloft.net,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] brcmfmac: fix typos in code comments
In-Reply-To: <20190520122825.981-1-houweitaoo@gmail.com>
References: <20190520122825.981-1-houweitaoo@gmail.com>
Message-ID: <c197d968f2a81325889be22e303d3dd0@milecki.pl>
X-Sender: rafal@milecki.pl
User-Agent: Roundcube Webmail/1.3.9
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
X-Ovh-Tracer-Id: 12409105824403590779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtkedgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-20 14:28, Weitao Hou wrote:
> fix lengh to length
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
> - fix prefix

Nice, thanks!
