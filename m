Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2C47C1CD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhLUOrF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 09:47:05 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:54008 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOrF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 09:47:05 -0500
Date:   Tue, 21 Dec 2021 14:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1640098019;
        bh=IyqeIFKhTaeTeQKhiGeMr9Ol7KKgCQLkFW1VkXgBzpM=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc;
        b=iWzNatTwftZUxXgL4/SRXGzEn/WZ23b9QiBpBxMiPkWZ7V1NHU78arU/6LsXNZlv3
         VqnirygegaJWkpkmIA1EknyW0BfdB/Zxn5zifxZL9aa01dAXSMcO8mbI58czSFVtWY
         vLJXXbNIJaj8ihmxftqZ93G3zkBHTtYRUt2vxaMmAmihgZTtMrghKeXesd7vanx/Ca
         sbgBMD4vHc9fWh8EbE5giG/FksM9HdmwHF9+Z6iKbqEmcpq78Rn3Cl0gN/wCfKs3UE
         gCqGq+6ED5FaCFgDkLZRulJkvfhBo5CrsaKRONlCr5KXbdh4EJR6bb3neVHFyE0e6G
         0TN1xR+rmxobA==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Michael Yartys <michael.yartys@protonmail.com>
Reply-To: Michael Yartys <michael.yartys@protonmail.com>
Subject: 802.11k, wpa_supplicant and iwlwifi
Message-ID: <zPg00UzBCn11SUYFks7vJunMuHmpeG8n6RCnf05uqUMjL8LO_XtWmhlQbDRWKO9_DwPvArE6GfghPZFlq871XKoujd4e6KSWPp8fabQkJOI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

From what I understand, wpa_supplicant only processes 802.11k frames if the=
 underlying driver indicates support for it through a flag. I haven't reall=
y found any information on whether this is the case for iwlwifi. Does anybo=
dy know if iwlwifi supports this? I don't know if this also depends on whic=
h wireless card that I use, so I'll include it in case it does: Intel 7260A=
C.

Regards
Michael
