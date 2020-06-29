Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27420D0B1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgF2SfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 14:35:12 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:50561 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF2SfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:12 -0400
Received: from [192.168.178.24] (unknown [91.53.47.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3CF94580076
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 19:40:03 +0200 (CEST)
To:     linux-wireless@vger.kernel.org
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Subject: RFC: Remote Off-Channel CAC for DFS
Message-ID: <c49513d5-9da7-5545-02e1-ff368f9f6961@tu-ilmenau.de>
Date:   Mon, 29 Jun 2020 19:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When using DFS channels, it would be nice, if I could dedicate a small
amount of interfaces only to CAC checking channels and set them
available or unavailable on multiple other remote APs/Mesh Points in
order to use them, when switching to lower utilized channels without
going through a full CAC.

Whats the opinion on the mailing list about adding a new command to
nl80211 in order to set the DFS state of a currently not used channel
after a Off-Channel CAC on another device nearby, but not on the same
host? The parameters would roughly be the same as for a channel switch
and an additional DFS channel state. Internally, I would trigger the DFS
state sync code between multiple interfaces.

Please note, that a malicious user, can misuse this and circumvent the
initial CAC, but this possibility is always there by patching the kernel
and all distribution kernels I'm aware off, are compiled without DFS
support configured. Therefore a malicious user has already put in some
energy and knows what he has to do. In my opinion this is therefore
negligible.

Regards,
Markus

