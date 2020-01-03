Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576E812F6C2
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgACKft (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 05:35:49 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgACKft (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 05:35:49 -0500
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.168]) with ESMTPSA (Nemesis)
 id 1MWixU-1jG0Da21pg-00X4iA; Fri, 03 Jan 2020 11:35:46 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH v2 0/2] Allow userspace to reset IBSS stations to fix aggregation issue
Date:   Fri,  3 Jan 2020 11:34:55 +0100
Message-Id: <20200103103457.22778-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.25.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x7R5bsc7V9ujghoT63VIdqCRvy+fSHbSwkMbYG2qTAQuDM5iRqJ
 wMpH+oGJctvRvoe9bLpQfdwOJrO1LQF1kD6iZE8BUEQM8sylsd/kNviypmKiLQ6u5HQ/nlU
 YYJBCLoH19n91qG3oFik+000oNCiD2mNZeUzu7goA2JX0EyHNAoXWwdkVSVQJRgoBOQaFQ8
 P0lFehifVQmGhHmdL4laA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ENoid2NsWF8=:9JClsFDFv/aBzjn15GFbyk
 W4sj9QR2sfytNopdrI6xjCLdoB6EqyKM1dXNKhWdE1am/D9GObFFu4NBb/sw3z+yeuvJURDNM
 qPPdQ/pWz48HkA+krlRzRevvRi0B3H3+d40r4G1tQJ1bno2oHU7WSOlhGeqStsoWlcw5OD1+P
 rsH3hY6xfzffH4PXxhUSsnUYHSo2EuAqb9pHkLBp480lmqkYOqH70LhjMMhlacenQxXhi3lG7
 wZc0aaAuQa7vrMT8/N0nHu/5w51E5ZYB6cgVS+QSvIyKSy82oA0DL3yfuyWii+f573DFs1+hM
 +WEgVf+7xSUcb6606aQrwtrL1te6HY3EsX1D0U4hFI8JVQIm+3E/iO++wO6iOIzqA64B+O0qJ
 peV+BdazeoJtqVZVkBQ0BBOzSHRLyA0QCPOQLxYpEEcCWTdd3G1oNopTITQuFy0sK5iOn0DMV
 1kdCS3rjDtPxkaMyLSOtWg8Gq1G7B3vDkVhoL1OItvehajntYQCT1D/8Gyxu3bKmrfV48LMqQ
 4cEZJYZUDffpnz9f8ayqgC31ZhtexUhmRaF3kuXdo18ieNg729xQhDRZv8IsCBeDjT3PNuF8r
 1U8BP1jBo+N8gGBzupVbN3thmz+HFHDENlXuhwDl3ZQcg+RRXeCUuKOuhAiAIkTxBu20GdANH
 KziR41d74TZsdP0TTFtox2+OCEdICV0e89haBgr+tJM+eS0LQ37G9Zz2JNMJFsgRHU8zostVi
 duM7UQ66u4s3vh8HKvJ6CgfknmVglzYskk9nQZwZLaFLTTeXk/iGhcV7lV+p559wdREiS3MWo
 OYFa3wwkmVtHtWOg+i9u3gBpMqy+fdWhV8ak3duEZwre5aw+u2RjRZTtBKSHLj3A8hGPx7612
 2nH1H9aqncojGm4uwtWQQDmPmiykGB1mN8VRvWEmoZ4ytAZAI+rRwjZJ82774m
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I encountered the same issue in an IBSS-RSN network, where quick reboot
of a station would cause issues with aggregation because the kernel is
not aware of the reboot.

I figured out that since wpa_supplicant already detect reboots, the
simplest way to fix it would be for wpa_supplicant to reset the entire
state of the station in the kernel, instead of just resetting keys and
port.

This means extending NL80211_CMD_DEL_STATION to work in IBSS mode too,
just like it does in mesh point mode.

Changes:
	v2: Use a nl80211 feature flag instead of patching every driver.


